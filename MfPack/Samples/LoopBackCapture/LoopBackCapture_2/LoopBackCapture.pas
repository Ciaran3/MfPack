// FactoryX
//
// Copyright: � FactoryX. All rights reserved.
//
// Project: MfPack - CoreAudio - WASAPI
// Project location: https://sourceforge.net/projects/MFPack
//                   https://github.com/FactoryXCode/MfPack
// Module: LoopBackCapture.pas
// Kind: Pascal / Delphi unit
// Release date: 02-04-2023
// Language: ENU
//
// Revision Version: 3.1.5
// Description: The audio loopbackcapture engine.
//
// Organisation: FactoryX
// Initiator(s): Tony (maXcomX), Peter (OzShips)
// Contributor(s): Tony Kalf (maXcomX), Peter Larson (ozships), Jacob C.
//
//------------------------------------------------------------------------------
// CHANGE LOG
// Date       Person              Reason
// ---------- ------------------- ----------------------------------------------
// 02/04/2023 All                 PiL release  SDK 10.0.22621.0 (Windows 11)
// 05/05/2023 Tony                Updated and fixed some isues.
//------------------------------------------------------------------------------
//
// Remarks: Requires Windows 10 or later.
//
// Related objects: -
// Related projects: MfPackX314
// Known Issues: -
//
// Compiler version: 23 up to 35
// SDK version: 10.0.22621.0
//
// Todo: -
//
//==============================================================================
// Source: LoopBackAudio Capture example.
//
//==============================================================================
//
// LICENSE
//
// The contents of this file are subject to the Mozilla Public License
// Version 2.0 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// https://www.mozilla.org/en-US/MPL/2.0/
//
// Software distributed under the License is distributed on an "AS IS"
// basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
// License for the specific language governing rights and limitations
// under the License.
//
// Non commercial users may distribute this sourcecode provided that this
// header is included in full at the top of the file.
// Commercial users are not allowed to distribute this sourcecode as part of
// their product.
//
//==============================================================================
unit LoopBackCapture;

interface

uses
  {WinApi}
  WinApi.Windows,
  WinApi.WinError,
  WinApi.WinApiTypes,
  WinApi.ComBaseApi,
  WinApi.Messages,
  {WinMM}
  WinApi.WinMM.MMeApi,
  {System}
  System.SysUtils,
  System.Classes,
  System.SyncObjs,
  {activeX}
  WinApi.ActiveX.PropIdl,
  WinApi.ActiveX.ObjBase,
  WinApi.ActiveX.ObjIdl,
  {MediaFoundationApi}
  WinApi.MediaFoundationApi.MfApi,
  WinApi.MediaFoundationApi.MfObjects,
  WinApi.MediaFoundationApi.MfUtils,
  WinApi.MediaFoundationApi.MfError,
  {CoreAudioApi}
  WinApi.CoreAudioApi.MMDeviceApi,
  WinApi.CoreAudioApi.AudioClient,
  WinApi.CoreAudioApi.AudioClientActivationParams,
  WinApi.CoreAudioApi.AudioSessionTypes,
  {Application}
  Common;


const
  BITS_PER_BYTE = 8;
  WM_PROGRESSNOTIFY = WM_USER + 1001;
  WM_RECORDINGSTOPPEDNOTYFY = WM_USER + 1002;

var
  oCriticalSection: TrtlCriticalSection;
  // Events should be declared in a global scope.
  gs_SampleReadyEvent: TEvent;
  gs_hActivateCompleted: TEvent;
  gs_hCaptureStopped: TEvent;

type
  // NB: All states >= Initialized will allow some methods
  // to be called successfully on the Audio Client
  TDeviceState = (Uninitialized,
                  Error,
                  Initialized,
                  Starting,
                  Capturing,
                  Stopping,
                  Stopped);

  TAsyncCmd = (StartCapture,
               StopCapture,
               SampleReady,
               FinishCapture);

  TWavFormat = (fmt44100, fmt48000);

type

  // Forwarded class
  TCallbackAsync = class;


  TLoopbackCapture = class(TInterfacedPersistent, IActivateAudioInterfaceCompletionHandler, IAgileObject)
  protected
    m_hPipe: HFILE;

  private

    m_AudioClient: IAudioClient3;
    m_AudioCaptureClient: IAudioCaptureClient;
    m_SampleReadyAsyncResult: IMFAsyncResult;

    m_xStartCapture: TCallbackAsync;
    m_xStopCapture: TCallbackAsync;
    m_xSampleReady: TCallbackAsync;
    m_xFinishCapture: TCallbackAsync;

    m_SampleReadyKey: MFWORKITEM_KEY;
    m_CaptureFormat: WAVEFORMATEX;
    m_BufferFrames: UINT32;

    m_dwTaskID: DWord;
    m_dwQueueID: DWord;
    m_cbHeaderSize: DWord;
    m_cbDataSize: DWord;
    m_WavFormat: TWavFormat;
    m_DevicePeriod: REFERENCE_TIME;

    hwOwner: HWND;

    // These two members are used to communicate between the main thread
    // and the ActivateCompleted callback.
    m_outputFileName: LPCWSTR;
    m_activateResult: HResult;

    m_DeviceState: TDeviceState;

    function OnStartCapture(pResult: IMFAsyncResult): HResult;
    function OnStopCapture(pResult: IMFAsyncResult): HResult;
    function OnFinishCapture(pResult: IMFAsyncResult): HResult;
    function OnSampleReady(pResult: IMFAsyncResult): HResult;

    function InitializeLoopbackCapture(): HResult;
    function CreateWAVFile(): HResult;
    function FixWAVHeader(): HResult;
    function OnAudioSampleRequested(): HResult;

    function ActivateAudioInterface(const processId: DWord;
                                    includeProcessTree: Boolean): HResult;
    function FinishCaptureAsync(): HResult;
    procedure Reset();
    procedure SetDeviceStateErrorIfFailed(hr: HResult);

  public

    constructor Create(hMF: HWND);
    destructor Destroy(); override;

  {$region IActivateAudioInterfaceCompletionHandler implementation}
    function ActivateCompleted(activateOperation: IActivateAudioInterfaceAsyncOperation): HResult; stdcall;
  {$endregion}

    function StartCaptureAsync(const hWindow: HWND;
                               const processId: DWord;
                               includeProcessTree: Boolean;
                               const wavFormat: TWavFormat;
                               const devicePeriod: REFERENCE_TIME;
                               const outputFileName: LPCWSTR): HResult;

    function StopCaptureAsync(): HResult;

    property WavFormat: TWavFormat read m_WavFormat;
    property AudioClientDevicePeriod: REFERENCE_TIME read m_DevicePeriod;

  end;

  //   ////////////////////////////////////////////////////////////////////////

  TCallbackAsync = class(TInterfacedPersistent, IMFAsyncCallback)
  private
    _parent: TLoopbackCapture;
    _dwQueueID: DWord;
    _AsyncCmd: TAsyncCmd;

  public

    constructor Create(AParent: TLoopbackCapture;
                       ASyncCmd: TAsyncCmd;
                       AQueueID: DWord = MFASYNC_CALLBACK_QUEUE_MULTITHREADED);
    destructor Destroy(); override;

  {$region IActivateAudioInterfaceCompletionHandler implementation}
    function GetParameters(out pdwFlags: DWord;
                           out pdwQueue: DWord): HResult; stdcall;
    function Invoke(pResult: IMFAsyncResult): HResult; stdcall;
  {$endregion}

    procedure SetQueueID(dwQueueID: DWord);

  end;

implementation




constructor TLoopbackCapture.Create(hMF: HWND);
begin
  inherited Create();
  hwOwner := hMF;
  m_activateResult := E_UNEXPECTED;
  m_DeviceState := Uninitialized;
  m_dwQueueID := 0;
  m_cbHeaderSize := 0;
  m_cbDataSize := 0;

  // Create the callback interfaces
  {StartCapture, StopCapture, SampleReady, FinishCapture}
  m_xStartCapture := TCallbackAsync.Create(Self, StartCapture);
  m_xStopCapture := TCallbackAsync.Create(Self, StopCapture);
  m_xSampleReady := TCallbackAsync.Create(Self, SampleReady);
  m_xFinishCapture := TCallbackAsync.Create(Self, FinishCapture);

end;


destructor TLoopbackCapture.Destroy();
begin
  Reset();
  FreeAndNil(m_xStartCapture);
  FreeAndNil(m_xStopCapture);
  FreeAndNil(m_xSampleReady);
  FreeAndNil(m_xFinishCapture);
  inherited Destroy();
end;


// IActivateAudioInterfaceCompletionHandler ////////////////////////////////////
//
//  ActivateCompleted()
//
//  Callback implementation of ActivateAudioInterfaceAsync function. This will be called on MTA thread
//  when results of the activation are available.
//
function TLoopbackCapture.ActivateCompleted(activateOperation: IActivateAudioInterfaceAsyncOperation): HRESULT;
var
  hr: HResult;
  hrActivateResult: HResult;

label
  leave;

begin
  m_CaptureFormat := Default(WAVEFORMATEX);

  // Check for a successful activation result
  hrActivateResult := E_UNEXPECTED;

  hr := activateOperation.GetActivateResult(hrActivateResult,
                                            IUnknown(m_AudioClient));
  if FAILED(hrActivateResult) or FAILED(hr) then
    begin
      hr := hrActivateResult;
      ErrMsg(Format('activateOperation.GetActivateResult failed. LastError = %d',[GetLastError()]), hrActivateResult);
      goto leave;
    end;

  // The app can call m_AudioClient.GetMixFormat to get the capture format if such is implemented.
  hr := m_AudioClient.GetMixFormat(@m_CaptureFormat);


  // Set 16 - bit PCM format manualy when we get an E_NOTIMPL result from GetMixFormat.
  if (hr = E_NOTIMPL) then
    begin
      m_CaptureFormat.wFormatTag := WAVE_FORMAT_PCM;
      m_CaptureFormat.nChannels := 2;

      if (m_WavFormat = fmt44100) then
        begin
          m_CaptureFormat.nSamplesPerSec := 44100;
          m_CaptureFormat.wBitsPerSample := 16;
        end
      else
        begin
          m_CaptureFormat.nSamplesPerSec := 48000;
          m_CaptureFormat.wBitsPerSample := 24;
        end;

      m_CaptureFormat.nBlockAlign := (m_CaptureFormat.nChannels * m_CaptureFormat.wBitsPerSample) div BITS_PER_BYTE;
      m_CaptureFormat.nAvgBytesPerSec := (m_CaptureFormat.nSamplesPerSec * m_CaptureFormat.nBlockAlign);
    end
  else if FAILED(hr) then
    goto leave;

  // Initialize the AudioClient in Shared Mode with the user specified buffer
  hr := m_AudioClient.Initialize(AUDCLNT_SHAREMODE_SHARED,
                                 AUDCLNT_STREAMFLAGS_LOOPBACK or AUDCLNT_STREAMFLAGS_EVENTCALLBACK,
                                 m_DevicePeriod, // Most hardware values are in between 100000 and 60000, 100ms/sec.
                                 0, // Must be zero in shared mode.
                                 @m_CaptureFormat,
                                 @GUID_NULL);
  if FAILED(hr) then
    goto leave;

  // Get the maximum size of the AudioClient Buffer
  hr := m_AudioClient.GetBufferSize(m_BufferFrames);
  if FAILED(hr) then
    goto leave;

  // Get the capture client
  hr := m_AudioClient.GetService(IID_IAudioCaptureClient,
                                 m_AudioCaptureClient);
  if FAILED(hr) then
    goto leave;

  // Create Async callback for sample events
  hr := MFCreateAsyncResult(nil,
                            m_xSampleReady,
                            nil,
                            m_SampleReadyAsyncResult);
  if FAILED(hr) then
    goto leave;

  // Tell the system which event handle it should signal when an audio buffer is ready to be processed by the client
  hr := m_AudioClient.SetEventHandle(gs_SampleReadyEvent.Handle);
  if FAILED(hr) then
    goto leave;

  // Creates the WAV file.
  hr := CreateWAVFile();
  if FAILED(hr) then
    goto leave;

  // Everything is ready.
  m_DeviceState := Initialized;

  // Let ActivateAudioInterface know that m_activateResult has the result of the activation attempt.
  gs_hActivateCompleted.SetEvent();

leave:
  Result := hr;

end;

////////////////////////////////////////////////////////////////////////////////

// PRIVATE

//
//  OnStartCapture()
//
//  Callback method to start the capture process.
//
function TLoopbackCapture.OnStartCapture(pResult: IMFAsyncResult): HResult;
var
  hr: HResult;

begin

  if Assigned(m_AudioClient) then
    begin
      // Start the capture
      hr := m_AudioClient.Start();

      if SUCCEEDED(hr) then
        begin
          m_DeviceState := Capturing;
          hr := MFPutWaitingWorkItem(gs_SampleReadyEvent.Handle,
                                     0,
                                     m_SampleReadyAsyncResult,
                                     m_SampleReadyKey);
        end;
    end
  else
    hr := E_POINTER;

  SetDeviceStateErrorIfFailed(hr);
  Result := hr;
end;


//
//  OnStopCapture()
//
//  Callback method to stop capture
//
function TLoopbackCapture.OnStopCapture(pResult: IMFAsyncResult): HResult;
var
  hr: HResult;

begin
  m_DeviceState := Stopping;
  // Stop capture by cancelling Work Item
  // Cancel the queued work item (if any)
  if (m_SampleReadyKey <> 0) then
    begin
        hr := MFCancelWorkItem(m_SampleReadyKey);
        if FAILED(hr) then
          ErrMsg(Format('MFCancelWorkItem failed. LastError = %d',[GetLastError()]), hr);
        m_SampleReadyKey := 0;
    end;

  hr := m_AudioClient.Stop();

  SafeRelease(m_SampleReadyAsyncResult);

  if SUCCEEDED(hr) then
    begin
      hr := FinishCaptureAsync();
      if SUCCEEDED(hr) then
        m_DeviceState := Stopped
      else
        begin
          m_DeviceState := Error;
          if FAILED(hr) then
            ErrMsg(Format('FinishCaptureAsync failed. LastError = %d',[GetLastError()]), hr);
        end;
    end;

  Result := hr;
end;


//
//  OnFinishCapture()
//
//  Because of the asynchronous nature of the MF Work Queues and the DataWriter, there could still be
//  a sample processing.  So this will get called to finalize the WAV header.
//
function TLoopbackCapture.OnFinishCapture(pResult: IMFAsyncResult): HResult;
var
  hr: HResult;

begin
  m_DeviceState := Stopping;
  // FixWAVHeader will set the DeviceStateStopped when all async tasks are complete
  hr := FixWAVHeader();

  if SUCCEEDED(hr) then
    begin
      gs_hCaptureStopped.SetEvent();
      hr := EventWait(gs_hCaptureStopped);
      if SUCCEEDED(hr) then
        begin
          m_DeviceState := Stopped;
          if (m_hPipe <> 0) then
            begin
              CloseHandle(m_hPipe);
              m_hPipe := 0;
              SendMessage(hwOwner,
                          WM_RECORDINGSTOPPEDNOTYFY,
                          0,
                          0);
            end;
        end;
    end
  else // nothing to play :-(
    begin
      m_DeviceState := Error;
      gs_hCaptureStopped.SetEvent();
      hr := EventWait(gs_hCaptureStopped);
    end;

  Result := hr;
end;


//
//  OnSampleReady()
//
//  Callback method when ready to fill sample buffer
//
function TLoopbackCapture.OnSampleReady(pResult: IMFAsyncResult): HResult;
var
  hr: HResult;

begin
  hr := OnAudioSampleRequested();
  if SUCCEEDED(hr) then
    begin
      // Re-queue work item for next sample
      if (m_DeviceState = Capturing) then
        begin
          // Re-queue work item for next sample
          hr := MFPutWaitingWorkItem(gs_SampleReadyEvent.Handle,
                                     0,
                                     m_SampleReadyAsyncResult,
                                     m_SampleReadyKey);
        end;
    end
  else
    m_DeviceState := Error;

  Result := hr;
end;


function TLoopbackCapture.InitializeLoopbackCapture(): HResult;
var
  hr: HResult;

label
  leave;
begin

  m_dwTaskID := 0;
  Reset();

  // Create events for sample ready or user stop
  gs_SampleReadyEvent := TEvent.Create(nil,
                                       False,
                                       False,
                                       '',
                                       True);

  // Register MMCSS work queue
  hr := MFLockSharedWorkQueue(PWideChar('Capture'),
                              MFASYNC_CALLBACK_QUEUE_MULTITHREADED,
                              m_dwTaskID,
                              m_dwQueueID);
  if FAILED(hr) then
    ErrMsg(Format('MFLockSharedWorkQueue failed. LastError = %d',[GetLastError()]), hr);

  // Set the capture event work queue to use the MMCSS queue
  m_xSampleReady.SetQueueID(m_dwQueueID);

  // Create the completion event as auto-reset
  gs_hActivateCompleted := TEvent.Create(nil,
                                         False,
                                         False,
                                         '',
                                         True);

  // Create the capture-stopped event as auto-reset
  gs_hCaptureStopped := TEvent.Create(nil,
                                      False,
                                      False,
                                      '',
                                      True);

leave:

  Result :=  hr;

end;


//
//  CreateWAVFile()
//
//  Creates a WAV file in music folder
//
function TLoopbackCapture.CreateWAVFile(): HResult;
var
  hr: HResult;
  br: BOOL;
  header: array [0..4] of DWord; // Each FOURCC (DWord) has a datalength of 4 bytes.
  data: array [0..1] of DWord;
  dwBytesWritten: DWord;

label
  leave;

begin
  hr := S_OK;
  dwBytesWritten := 0;

  m_hPipe := CreateFile(m_outputFileName,
                        GENERIC_WRITE,
                        0,
                        nil,
                        CREATE_ALWAYS,
                        FILE_ATTRIBUTE_NORMAL,
                        0);
  if (m_hPipe = Int(INVALID_HANDLE_VALUE)) then
    begin
      hr := E_FAIL;
      m_hPipe := 0;
      ErrMsg(Format('CreateFile(%s) failed. LastError = %d',[WideCharToString(m_outputFileName), GetLastError()]), hr);
      goto leave;
    end;


  // Create and write the WAV header

  // 1. RIFF chunk descriptor
  header[0] := FCC('RIFF'); // 4 bytes
  header[1] := 0;           // 4 bytes, total size of WAV (will be filled in later)
  header[2] := FCC('WAVE'); // 4 bytes, WAVE FourCC.
  // Start of 'fmt ' chunk
  header[3] := FCC('fmt '); // 4 bytes, Start of 'fmt ' chunk.
  header[4] := SizeOf(m_CaptureFormat); // 4 bytes, Size of fmt chunk.


  br := WriteFile(m_hPipe,
                  header,
                  SizeOf(header),
                  dwBytesWritten,
                  nil);
  if (br = False) then
    begin
      hr := E_FAIL;
      goto leave;
    end;

  inc(m_cbHeaderSize,
      dwBytesWritten);

  // 2. The fmt sub-chunk
  {$IFDEF DEBUG}
  ASSERT(m_CaptureFormat.cbSize = 0);
  {$ENDIF}

  br := WriteFile(m_hPipe,
                  m_CaptureFormat,
                  SizeOf(m_CaptureFormat),
                  dwBytesWritten,
                  nil);
  if (br = False) then
    begin
      hr := E_FAIL;
      goto leave;
    end;

  inc(m_cbHeaderSize,
      dwBytesWritten);

  // 3. The data sub-chunk
  data[0] := FCC('data'); // 4 bytes, Start of 'data' chunk
  data[1] := 0;           // 4 bytes


  br := WriteFile(m_hPipe,
                  data, sizeof(data),
                  dwBytesWritten,
                  nil);
  if (br = False) then
    begin
      hr := E_FAIL;
      goto leave;
    end;

  inc(m_cbHeaderSize,
      dwBytesWritten);

leave:
  Result := hr;
end;


//
//  FixWAVHeader()
//
//  The size values were not known when we originally wrote the header, so now go through and fix the values.
//
function TLoopbackCapture.FixWAVHeader(): HResult;
var
  hr: HResult;
  dwPtr: DWord;
  dwBytesWritten: DWord;
  cbTotalSize: DWord;

label
  leave;

begin
  // Write the size of the 'data' chunk first
  dwPtr := SetFilePointer(m_hPipe,
                          m_cbHeaderSize - SizeOf(DWord),
                          nil,
                          FILE_BEGIN);
  if (dwPtr = INVALID_SET_FILE_POINTER) then
    begin
      hr := E_FAIL;
      ErrMsg(Format('SetFilePointer failed with result %d. LastError = %d',[dwPtr, GetLastError()]), hr);
    end;

  if not WriteFile(m_hPipe,
                   m_cbDataSize,
                   SizeOf(DWord),
                   dwBytesWritten,
                   nil) then
    begin
      hr := E_FAIL;
      ErrMsg(Format('WriteFile failed. LastError = %d',[GetLastError()]), hr);
    end;

  // Write the total file size, minus RIFF chunk and size
  // SizeOf(DWord) = SizeOf(FOURCC)
  dwPtr := SetFilePointer(m_hPipe,
                          SizeOf(DWord),
                          nil,
                          FILE_BEGIN);
  if (dwPtr = INVALID_SET_FILE_POINTER) then
    begin
      hr := E_FAIL;
      ErrMsg(Format('SetFilePointer failed with result %d. LastError = %d',[dwPtr, GetLastError()]), hr);
    end;

  cbTotalSize := (m_cbDataSize + m_cbHeaderSize) - 8;
  if not WriteFile(m_hPipe,
                   cbTotalSize,
                   SizeOf(DWord),
                   dwBytesWritten,
                   nil) then
    begin
      hr := E_FAIL;
      ErrMsg(Format('WriteFile failed. LastError = %d',[GetLastError()]), hr);
    end;

  if not FlushFileBuffers(m_hPipe) then
    begin
      hr := E_FAIL;
      ErrMsg(Format('FlushFileBuffers failed. LastError = %d',[GetLastError()]), hr);
    end;
leave:
  Result := S_OK;
end;


//
//  OnAudioSampleRequested()
//
//  Called when audio device fires m_SampleReadyEvent
//
function TLoopbackCapture.OnAudioSampleRequested(): HResult;
var
  hr: HResult;
  br: BOOL;
  FramesAvailable: UINT32;
  Data: Pointer;
  dwCaptureFlags: DWord;
  u64DevicePosition: UINT64;
  u64QPCPosition: UINT64;
  cbBytesToCapture: DWord;
  dwBytesWritten: DWord;
  NumBytesWritten: INT64;

label
  leave;

begin

  EnterCriticalSection(oCriticalSection);
  hr := S_OK;
  NumBytesWritten := 0;
  Data := nil;

  // If this flag is set, we have already queued up the async call to finialize the WAV header
  // So we don't want to grab or write any more data that would possibly give us an invalid size
  if (m_DeviceState = Stopping) or (m_DeviceState = Stopped) or (m_DeviceState = Error) then
    goto leave;

  // A word on why we have a loop here;
  // Suppose it has been 10 milliseconds or so since the last time
  // this routine was invoked, and that we're capturing 48000 samples per second.
  //
  // The audio engine can be reasonably expected to have accumulated about that much
  // audio data - that is, about 480 samples.
  //
  // However, the audio engine is free to accumulate this in various ways:
  // a. as a single packet of 480 samples, OR
  // b. as a packet of 80 samples plus a packet of 400 samples, OR
  // c. as 48 packets of 10 samples each.
  //
  // In particular, there is no guarantee that this routine will be
  // run once for each packet.
  //
  // So every time this routine runs, we need to read ALL the packets
  // that are now available;
  //
  // We do this by calling IAudioCaptureClient.GetNextPacketSize
  // over and over again until it indicates there are no more packets remaining.

  //while SUCCEEDED(m_AudioCaptureClient.GetNextPacketSize(FramesAvailable)) and (FramesAvailable > 0) do

  while (m_DeviceState <> Stopping) or (m_DeviceState <> Stopped) or (m_DeviceState <> Error) do
    begin

      if not Assigned(m_AudioCaptureClient) then
        Break;

      hr := m_AudioCaptureClient.GetNextPacketSize(FramesAvailable);
      if FAILED(hr) then
        begin
          StopCaptureAsync();
          break;
        end;

      cbBytesToCapture := FramesAvailable * m_CaptureFormat.nBlockAlign;


      // WAV files have a 4GB (0xFFFFFFFF) size limit, so likely we have hit that limit when we
      // overflow here.  Time to stop the capture
      if ((m_cbDataSize + cbBytesToCapture) < m_cbDataSize) then
        begin
          StopCaptureAsync();
          break;
        end;

        // Get sample buffer
        hr := m_AudioCaptureClient.GetBuffer(PByte(Data),
                                             FramesAvailable,
                                             dwCaptureFlags,
                                             @u64DevicePosition,
                                             @u64QPCPosition);
        if FAILED(hr) then
          begin
             ErrMsg(Format('m_AudioCaptureClient.GetBuffer failed. LastError = %d',[GetLastError()]), hr);
             break;
          end;

        // Write File
        if (m_DeviceState <> Stopping) or (m_DeviceState <> Stopped) or (m_DeviceState <> Error) then
          begin
            dwBytesWritten := 0;
            br := WriteFile(m_hPipe,
                            Data^,
                            cbBytesToCapture,
                            dwBytesWritten,
                            nil);
            if (br = False) then
              begin
                ErrMsg(Format('%s LastError = %d',[SysErrorMessage(GetLastError), GetLastError()]), E_FAIL);
                break;
              end;
          end;

        // Increase the size of our 'data' chunk. m_cbDataSize needs to be accurate.
        inc(m_cbDataSize, cbBytesToCapture);
        inc(NumBytesWritten, dwBytesWritten);

        HandleThreadMessages(GetCurrentThread());
        // Send score. Don't use PostMessage because it set priority above this thread.
        SendMessage(hwOwner,
                    WM_PROGRESSNOTIFY,
                    NumBytesWritten,
                    0);
        Data := nil;

        // Release buffer back
        hr := m_AudioCaptureClient.ReleaseBuffer(FramesAvailable);
    end;

leave:
  LeaveCriticalSection(oCriticalSection);
  Result := hr;
end;


function TLoopbackCapture.ActivateAudioInterface(const processId: DWord;
                                                 includeProcessTree: Boolean): HResult;
var
  hr: HResult;
  audioclientActivationParams: AUDIOCLIENT_ACTIVATION_PARAMS;
  activateParams: PROPVARIANT;
  asyncOp: IActivateAudioInterfaceAsyncOperation;

label
  leave;

begin

  audioclientActivationParams.ActivationType := AUDIOCLIENT_ACTIVATION_TYPE_PROCESS_LOOPBACK;

  if includeProcessTree then
    audioclientActivationParams.ProcessLoopbackParams.ProcessLoopbackMode := PROCESS_LOOPBACK_MODE_INCLUDE_TARGET_PROCESS_TREE
  else
    audioclientActivationParams.ProcessLoopbackParams.ProcessLoopbackMode := PROCESS_LOOPBACK_MODE_EXCLUDE_TARGET_PROCESS_TREE;

  audioclientActivationParams.ProcessLoopbackParams.TargetProcessId := processId;

  PropVariantInit(activateParams);

  activateParams.vt := VT_BLOB;
  activateParams.blob.cbSize := SizeOf(audioclientActivationParams);

  activateParams.blob.pBlobData := PByte(@audioclientActivationParams);

  hr := ActivateAudioInterfaceAsync(LPCWSTR(VIRTUAL_AUDIO_DEVICE_PROCESS_LOOPBACK),
                                    IID_IAudioClient,
                                    activateParams,
                                    Self,
                                    asyncOp);
  if FAILED(hr) then
    begin
      ErrMsg(Format('ActivateAudioInterfaceAsync failed. LastError = %d',[GetLastError()]), hr);
      goto leave;
    end;

  hr := EventWait(gs_hActivateCompleted);

leave:
  PropVariantClear(activateParams);
  SetDeviceStateErrorIfFailed(hr);

  Result := hr;
end;


//
//  FinishCaptureAsync()
//
//  Finalizes WAV file on a separate thread via MF Work Item.
//
function TLoopbackCapture.FinishCaptureAsync(): HResult;
var
  hr: HResult;

begin
  // We should be flushing when this is called
  hr := MFPutWorkItem2(MFASYNC_CALLBACK_QUEUE_MULTITHREADED,
                       0,
                       m_xFinishCapture,
                       nil);
  if FAILED(hr) then
    begin
      m_DeviceState := Error;
      ErrMsg(Format('MFPutWorkItem2 failed. LastError = %d',[GetLastError()]), hr);
    end;


  Result := hr;
end;


procedure TLoopbackCapture.Reset();
var
  hr: HResult;

begin
  hr := S_OK;

try

  m_activateResult := E_UNEXPECTED;
  m_DeviceState := Uninitialized;
  m_cbHeaderSize := 0;
  m_cbDataSize := 0;

  if (m_dwQueueID <> 0) then
    MFUnlockWorkQueue(m_dwQueueID);

  if (m_hPipe <> 0) then
    begin
      CloseHandle(m_hPipe);
      m_hPipe := 0;
    end;

  // Free the events but reset first and then wait until all events are processed.
  if Assigned(gs_SampleReadyEvent) then
    begin
      gs_SampleReadyEvent.ResetEvent;
      hr := EventWait(gs_SampleReadyEvent);
      FreeAndNil(gs_SampleReadyEvent);
    end;

  if Assigned(gs_hActivateCompleted) then
    begin
      gs_hActivateCompleted.ResetEvent;
      hr := EventWait(gs_hActivateCompleted);
      FreeAndNil(gs_hActivateCompleted);
    end;

  if Assigned(gs_hCaptureStopped) then
    begin
      gs_hCaptureStopped.ResetEvent;
      hr := EventWait(gs_hCaptureStopped);
      FreeAndNil(gs_hCaptureStopped);
    end;

  if FAILED(hr) then
    ErrMsg(Format('A ResetEvent failed. LastError = %d',[GetLastError()]), hr);

except
  Abort;
end;
end;


procedure TLoopbackCapture.SetDeviceStateErrorIfFailed(hr: HResult);
begin
  if FAILED(hr) then
    m_DeviceState := Error;
end;


// PUBLIC

function TLoopbackCapture.StartCaptureAsync(const hWindow: HWND;
                                            const processId: DWord;
                                            includeProcessTree: Boolean;
                                            const wavFormat: TWavFormat;
                                            const devicePeriod: REFERENCE_TIME;
                                            const outputFileName: LPCWSTR): HResult;
var
  hr: HResult;
label
  leave;

begin

  if (outputFileName = nil) then
    begin
      hr := E_POINTER;
      goto leave;
    end;

  if (hWindow = 0) then
    begin
      hr := E_POINTER;
      goto leave;
    end;

  hwOwner := hWindow;
  m_outputFileName := outputFileName;
  m_DevicePeriod := DevicePeriod;

  hr := InitializeLoopbackCapture();
  if FAILED(hr) then
    begin
      ErrMsg(Format('InitializeLoopbackCapture failed. LastError = %d',[GetLastError()]), hr);
      goto leave;
    end;

  // Activate the audio interface
  hr := ActivateAudioInterface(processId,
                               includeProcessTree);
  if FAILED(hr) then
    begin
      ErrMsg(Format('ActivateAudioInterface failed. LastError = %d',[GetLastError()]), hr);
      goto leave;
    end;

  // We should be in the initialzied state if this is the first time through getting ready to capture.
  if (m_DeviceState = Initialized) then
    begin
      m_DeviceState := Starting;
      hr := MFPutWorkItem2(MFASYNC_CALLBACK_QUEUE_MULTITHREADED,
                           0,
                           m_xStartCapture,  // the callback interface
                           nil);
      if FAILED(hr) then
        begin
          ErrMsg(Format('MFPutWorkItem2 failed. LastError = %d',[GetLastError()]), hr);
          goto leave;
        end;
    end;

leave:
  Result := hr;
end;


//
//  StopCaptureAsync()
//
//  Stop capture asynchronously via MF Work Item.
//
function TLoopbackCapture.StopCaptureAsync(): HResult;
var
  hr: HResult;

begin
  hr := S_OK;
  if (m_DeviceState <> Capturing) and
     (m_DeviceState <> Error) then
    begin
      hr := E_NOT_VALID_STATE;
    end;

  if SUCCEEDED(hr) then
    begin
      m_DeviceState := Stopping;

      hr := MFPutWorkItem2(MFASYNC_CALLBACK_QUEUE_MULTITHREADED,
                           0,
                           m_xStopCapture,
                           nil);
      if SUCCEEDED(hr) then
        hr := EventWait(gs_hCaptureStopped);
    end;

  Result := hr;
end;


// TAsyncCallback //////////////////////////////////////////////////////////////

constructor TCallbackAsync.Create(AParent: TLoopbackCapture;
                                  ASyncCmd: TAsyncCmd;
                                  AQueueID: DWord);
begin
  inherited Create();
  _parent := AParent;
  _AsyncCmd := ASyncCmd;
  _dwQueueID := AQueueID;
end;


destructor TCallbackAsync.Destroy();
begin

  inherited Destroy();
end;


function TCallbackAsync.GetParameters(out pdwFlags: DWord;
                                      out pdwQueue: DWord): HResult;
begin
  pdwFlags := 0;
  pdwQueue := _dwQueueID;
  Result := S_OK;
end;


// All callbacks are derived from this and will process this invoke.
function TCallbackAsync.Invoke(pResult: IMFAsyncResult): HResult;
var
  hr: HResult;

begin
  case _AsyncCmd of
    StartCapture:  hr := _parent.OnStartCapture(pResult);
    StopCapture:   hr := _parent.OnStopCapture(pResult);
    SampleReady:   hr := _parent.OnSampleReady(pResult);
    FinishCapture: hr := _parent.OnFinishCapture(pResult);
    else
      hr := S_FALSE;  // No error, but wrong command.
  end;
  Result := hr;
end;


procedure TCallbackAsync.SetQueueID(dwQueueID: DWord);
begin
  _dwQueueID := dwQueueID;
end;


initialization
  InitializeCriticalSection(oCriticalSection);

  if FAILED(MFStartup(MF_VERSION,
                      MFSTARTUP_LITE)) then
      begin
        MessageBox(0,
                   lpcwstr('Your computer does not support this Media Foundation API version' +
                           IntToStr(MF_VERSION) + '.'),
                   lpcwstr('MFStartup Failure!'),
                   MB_ICONSTOP);
      end;

finalization
  DeleteCriticalSection(oCriticalSection);
  MFShutdown();

end.
