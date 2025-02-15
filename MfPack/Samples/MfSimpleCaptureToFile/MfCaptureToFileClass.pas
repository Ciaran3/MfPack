// FactoryX
//
// Copyright � by FactoryX, Netherlands/Australia
//
// Project: Media Foundation - MFPack - Samples
// Project location: https://sourceforge.net/projects/MFPack
//                   https://github.com/FactoryXCode/MfPack
// Module: MfCaptureToFileClass.pas
// Kind: Pascal Unit
// Release date: 09-02-2018
// Language: ENU
//
// Revision Version: 3.1.4
//
// Description: Device capture class based on MFCaptureToFile example
//
// Company: FactoryX
// Intiator(s): Tony (maXcomX), Peter (OzShips)
// Contributor(s): Tony Kalf (maXcomX), Peter Larson (ozships), (Ciaran), (TopPlay)
//
//------------------------------------------------------------------------------
// CHANGE LOG
// Date       Person              Reason
// ---------- ------------------- ----------------------------------------------
// 28/08/2022 All                 PiL release  SDK 10.0.22621.0 (Windows 11)
// 04/03/2023                     Updated device loss notify.
//------------------------------------------------------------------------------
//
// Remarks: Requires Windows 7 or higher.
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
// =============================================================================
// Source: FSimpleCapture Example.
//
// https://github.com/Microsoft/Windows-classic-samples/tree/master/Samples/Win7Samples/multimedia/mediafoundation/MFCaptureToFile
//
// Copyright (c) Microsoft Corporation. All rights reserved
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
unit MfCaptureToFileClass;

interface
uses
  {WinApi}
  WinApi.Windows,
  WinApi.Messages,
  WinApi.WinApiTypes,
  WinApi.ComBaseApi,
  WinApi.Ks,
  WinApi.WinError,
  {System}
  System.Services.Dbt,
  System.SysUtils,
  System.Classes,
  System.SyncObjs,
  {ActiveX}
  WinApi.ActiveX.ObjBase,
  WinApi.ActiveX.PropIdl,
  {MfPack}
  WinApi.MediaFoundationApi.MfUtils,
  WinApi.MediaFoundationApi.MfMetLib,
  WinApi.MediaFoundationApi.MfApi,
  WinApi.MediaFoundationApi.MfIdl,
  WinApi.MediaFoundationApi.MfObjects,
  WinApi.MediaFoundationApi.MfReadWrite,
  WinApi.MediaFoundationApi.WmCodecDsp,
  WinApi.MediaFoundationApi.Evr,
  WinApi.MediaFoundationApi.Evr9;

  {$TYPEINFO ON}

const

  WM_APP_PREVIEW_ERROR = WM_APP + 1;    // wparam = HRESULT


type


  TDeviceList = class
  protected
    m_cDevices: UINT32;
    m_ppDevices: PIMFActivate; // Pointer to IMFActivate array

  public
    // Contructor & destructor
    //
    constructor Create(); overload;
    // Call cleanups from here
    procedure BeforeDestruction(); override;
    // Caller should call Release.
    destructor Destroy(); override;

    procedure Clear();
    function Count(): UINT32; // { return m_cDevices; }
    function EnumerateDevices(): HRESULT;
    function GetDevice(const index: UINT32;
                       out ppActivate: IMFActivate): HRESULT;
    function GetDeviceName(const index: UINT32;
                           out strName: string): HRESULT;
    function GetDeviceSymLink(const index: UINT32;
                              out ppszSymLink: PWideChar): HRESULT;
  end;


  EncodingParameters = record
    subtype: TGUID;
    bitrate: UINT32;
  end;


  TState = (State_NotReady = 0,
            State_Ready,
            State_Capturing);

  // MediaFoundation status.
  TMfStatus = (MfStarted,
               MfStopped);



type

  TCaptureToFile = class(TInterfacedPersistent, IMFSourceReaderCallback)
  protected
    m_State: TState;
    m_hwndEvent: HWND;         // Application window to receive events.

    m_pReader: IMFSourceReader;
    m_pWriter: IMFSinkWriter;

    m_bFirstSample: BOOL;
    m_llBaseTime: LongLong;

    m_strSymbolicLink: string;
    m_strName: string;

    function ConfigureCapture(var param: EncodingParameters): HResult;
    function EndCaptureInternal(): HResult;

    // IMFSourceReaderCallback /////////////////////////////////////////////////
    function OnReadSample(hrStatus: HRESULT;
                          dwStreamIndex: DWORD;
                          dwStreamFlags: DWORD;
                          llTimestamp: LONGLONG;
                          pSample: IMFSample): HResult; stdcall;

    function OnFlush(dwStreamIndex: DWORD): HResult; stdcall;

    function OnEvent(dwStreamIndex: DWORD;
                     pEvent: IMFMediaEvent): HResult; stdcall;

    ////////////////////////////////////////////////////////////////////////////

  public

    // Constructor & destuctor
    //
    constructor Create(hMainForm: HWND); reintroduce;
    // Clean up al objects here, before destroy is called
    procedure BeforeDestruction(); override;
    // Caller should call Release.
    destructor Destroy(); override;

    // Clear and reset all objects by calling EndCaptureInternal()
    procedure Clear();
    function StartCapture(pActivate: IMFActivate;
                          const wszFileName: WideString;
                          param: EncodingParameters): HResult;
    function EndCaptureSession(): HResult;
    function IsCapturing(): BOOL;

  published
    property State: TState read m_State write m_State;
    property DeviceName: string read m_strName;
    property DeviceSymbolicLink: string read m_strSymbolicLink;
end;

var
  MfDeviceList: TDeviceList;
  MfStatus: TMfStatus;       // Status of MediaFoundation


// Helpers
//========

  function ConfigureSourceReader(pReader: IMFSourceReader): HRESULT;

  function ConfigureEncoder(const params: EncodingParameters;
                            pType: IMFMediaType;
                            pWriter: IMFSinkWriter;
                            pdwStreamIndex: DWORD): HRESULT;

  function CopyAttribute(pSrc: IMFAttributes;
                         pDest: IMFAttributes;
                         const key: REFGUID): HRESULT;

  // Register for Device Notification.
  // Before you start capturing from a device, call the RegisterDeviceNotification
  // function to register for device notifications.
  // Register for the KSCATEGORY_CAPTURE device class, as shown in this function.


implementation


// TCaptureToFile
////////////////////////////////////////////////////////////////////////////////

procedure TCaptureToFile.Clear();
begin
  m_hwndEvent := 0;
  m_bFirstSample := False;
  m_llBaseTime := 0;
  EndCaptureInternal();
end;


// Constructor & destructor section ////////////////////////////////////////////
constructor TCaptureToFile.Create(hMainForm: HWND);
begin
  inherited Create();

  if (MfStatus = MfStarted) then
    begin
      m_hwndEvent := hMainForm;
    end;
end;

//
procedure TCaptureToFile.BeforeDestruction();
begin
  Clear();

  MfDeviceList.Free;
  MfDeviceList := nil;

  MFShutdown();
  CoUninitialize;

  inherited;
end;


// Caller should call Release!!
destructor TCaptureToFile.Destroy();
begin

  inherited Destroy();
end;

// End Constructor & destructor section ////////////////////////////////////////




// Event methods ///////////////////////////////////////////////////////////////

function TCaptureToFile.OnReadSample(hrStatus: HRESULT;
                                     dwStreamIndex: DWORD;
                                     dwStreamFlags: DWORD;
                                     llTimestamp: LONGLONG;
                                     pSample: IMFSample): HResult; stdcall;
var
  hr: HRESULT;

label
  Done;

begin

  if (State = State_NotReady) then
    begin
      Result := S_OK;
      Exit;
    end;


  if (IsCapturing() = False) then
    begin
      Result := S_OK;
      Exit;
    end;

  if FAILED(hrStatus) then
    begin
      hr := hrStatus;
      goto Done;
    end;

  if Assigned(pSample) then
    begin
      if m_bFirstSample then
        begin
          m_llBaseTime := llTimeStamp;
          m_bFirstSample := False;
          State := State_Capturing;
        end;

      // rebase the time stamp
      llTimeStamp := llTimeStamp - m_llBaseTime;

      hr := pSample.SetSampleTime(llTimeStamp);

      if (FAILED(hr)) then { goto done; }
        goto Done;

      hr := pSample.SetUINT32(MFSampleExtension_Discontinuity,
                              0);

      if (FAILED(hr)) then { goto done; }
       goto Done;

      hr := m_pWriter.WriteSample(0,
                                  pSample);

      if FAILED(hr) then { goto done; }
        goto Done;

      pSample := nil;  // Must do!
    end;

  // Read another sample.
  hr := m_pReader.ReadSample(MF_SOURCE_READER_FIRST_VIDEO_STREAM,
                             0,
                             nil,
                             nil,
                             nil,
                             nil);

  // check the StreamFlags
    if SUCCEEDED(hr) then
      begin
        case dwStreamFlags of
        DWORD(MF_SOURCE_READERF_ERROR):                    begin {An error occurred.
                                                           If you receive this flag, do not make any further calls to IMFSourceReader methods.
                                                           } end;
        DWORD(MF_SOURCE_READERF_ENDOFSTREAM):              begin {The source reader reached the end of the stream.} end;
        DWORD(MF_SOURCE_READERF_NEWSTREAM):                begin {One or more new streams were created.
                                                           Respond to this flag by doing at least one of the following:
                                                            - Set the output types on the new streams.
                                                            - Update the stream selection by selecting or deselecting streams.
                                                          } end;
        DWORD(MF_SOURCE_READERF_NATIVEMEDIATYPECHANGED):   begin {The native format has changed for one or more streams.
                                                          The native format is the format delivered by the media source before any decoders are inserted.
                                                          } end;
        DWORD(MF_SOURCE_READERF_CURRENTMEDIATYPECHANGED):  begin {The current media has type changed for one or more streams.
                                                           To get the current media type, call the IMFSourceReader.GetCurrentMediaType method.
                                                           } end;
        DWORD(MF_SOURCE_READERF_STREAMTICK):               begin {There is a gap in the stream.
                                                           This flag corresponds to an MEStreamTick event from the media source.
                                                           } end;
        DWORD(MF_SOURCE_READERF_ALLEFFECTSREMOVED):        begin {All transforms inserted by the application have been removed for a particular stream.
                                                           This could be due to a dynamic format change from a source or decoder that prevents custom transforms from
                                                           being used because they cannot handle the new media type.
                                                           } end;
        else
          // Set text in Mainwindow caption
          SetWindowText(m_hwndEvent,
                        'Capturing: ' + HnsTimeToStr((llTimeStamp), true));
        end;
      end;


Done:

  SafeRelease(pSample);  // Must do! Else the sample pool will be exhausted after 20 samples
  if FAILED(hr) then
    SetWindowText(m_hwndEvent,
                  'Capture Failure! (' + IntToStr(hr) + ')');


  Result := hr;
end;


function TCaptureToFile.OnFlush(dwStreamIndex: DWORD): HRESULT;
begin
  // Empty for now
  Result := S_OK;
end;


function TCaptureToFile.OnEvent(dwStreamIndex: DWORD;
                                pEvent: IMFMediaEvent): HRESULT;
var
  hr: HRESULT;
  pmet: MediaEventType;

begin
  // For example...
  hr := pEvent.GetType(pmet);

  // Possible pEvent values
  //========================
  // MEBufferingStarted
  // MEBufferingStopped
  // MEConnectEnd
  // MEConnectStart
  // MEExtendedType
  // MESourceCharacteristicsChanged
  // MESourceMetadataChanged

  Result := hr;
end;


// End Event methods ///////////////////////////////////////////////////////////


// Public methods //////////////////////////////////////////////////////////////


//-------------------------------------------------------------------
// ConfigureCapture
//
// Configures the capture session.
//
//-------------------------------------------------------------------
function TCaptureToFile.ConfigureCapture(var param: EncodingParameters): HRESULT;
var
  hr: HRESULT;
  sink_stream: DWORD;
  pType: IMFMediaType;

begin

  sink_stream := 0;

  hr:= ConfigureSourceReader(m_pReader);

  if SUCCEEDED(hr) then
    hr:= m_pReader.GetCurrentMediaType(DWORD(MF_SOURCE_READER_FIRST_VIDEO_STREAM),
                                       pType);

  if SUCCEEDED(hr) then
    hr := ConfigureEncoder(param,
                           pType,
                           m_pWriter,
                           sink_stream);

  if SUCCEEDED(hr) then
    begin
      // Register the color converter DSP for this process, in the video
      // processor category. This will enable the sink writer to enumerate
      // the color converter when the sink writer attempts to match the
      // media types.

      hr := MFTRegisterLocalByCLSID(CLSID_CColorConvertDMO,
                                    MFT_CATEGORY_VIDEO_PROCESSOR,
                                    LPCWSTR(''),
                                    MFT_ENUM_FLAG_SYNCMFT,
                                    0,
                                    nil,
                                    0,
                                    nil);
    end;

  if SUCCEEDED(hr) then
    hr := m_pWriter.SetInputMediaType(sink_stream,
                                      pType,
                                      nil);


  Result := hr;
end;


//------------------------------------------------------------------------------
// EndCaptureInternal
//
// Stops capture.
//------------------------------------------------------------------------------
function TCaptureToFile.EndCaptureInternal(): HRESULT;
var
  hr: HRESULT;

begin
  hr := S_OK;

  if Assigned(m_pWriter) then
    hr := m_pWriter.Finalize();

  SafeRelease(m_pWriter);
  SafeRelease(m_pReader);

  Result := hr;
end;



//------------------------------------------------------------------------------
// StartCapture
//
// Start capturing.
//------------------------------------------------------------------------------
function TCaptureToFile.StartCapture(pActivate: IMFActivate;
                                     const wszFileName: WideString;
                                     param: EncodingParameters): HRESULT;
var
  hr: HRESULT;
  pSource: IMFMediaSource;
  pAttributes: IMFAttributes;
  pcchLength: UINT32;
  pFileName: PWideChar;
  pDeviceName: PWideChar;
  pSymLink: PWideChar;

label
  done;

begin

  pFileName := StrToPWideChar(wszFileName);

  // Create the media source for the device.
  hr := pActivate.ActivateObject(IID_IMFMediaSource,
                                 Pointer(pSource));
  if FAILED(hr) then
    goto done;

  // Get the symbolic link. This is needed to handle device-
  // loss notifications. (See CheckDeviceLost.)
  hr := pActivate.GetAllocatedString(MF_DEVSOURCE_ATTRIBUTE_SOURCE_TYPE_VIDCAP_SYMBOLIC_LINK,
                                     pSymLink,
                                     pcchLength);
  if FAILED(hr) then
    goto done;

  m_strSymbolicLink := WideCharToString(pSymLink);

  // Get displayed device name
  hr := pActivate.GetAllocatedString(MF_DEVSOURCE_ATTRIBUTE_FRIENDLY_NAME,
                                     pDeviceName,
                                     pcchLength);
  if FAILED(hr) then
    goto done;

  m_strName := WideCharToString(pDeviceName);

  hr := MFCreateAttributes(pAttributes,
                           2);
  if FAILED(hr) then
    goto done;

  hr:= pAttributes.SetUnknown(MF_SOURCE_READER_ASYNC_CALLBACK,
                              Self);
  if FAILED(hr) then
    goto done;

  hr:= MFCreateSourceReaderFromMediaSource(pSource,
                                           pAttributes,
                                           m_pReader);
  if FAILED(hr) then
    goto done;

  // Create the sink writer
  hr := MFCreateSinkWriterFromURL(pFileName,
                                  nil,
                                  nil,
                                  m_pWriter);
  if FAILED(hr) then
    goto done;

  // Set up the encoding parameters.
  hr := ConfigureCapture(param);
  if FAILED(hr) then
    goto done;


  m_bFirstSample := True;
  m_llBaseTime := 0;

  // Request the first video frame.
  // This function will fire the OnReadSample events.
  hr := m_pReader.ReadSample(MF_SOURCE_READER_FIRST_VIDEO_STREAM,
                             0,
                             nil,
                             nil,
                             nil,
                             nil);  // No sample needed for first time.
  if FAILED(hr) then
    goto done;

  // Begin writing (must be initialized before any atempt by the sink is made to write data to the file.)
  State := State_Capturing;
  hr := m_pWriter.BeginWriting();

done:
  Result := hr;
end;

//------------------------------------------------------------------------------
// EndCaptureSession
//
// Stop the capture session.
//
// NOTE: This method resets the object's state to State_NotReady.
// To start another capture session, call SetCaptureFile.
//------------------------------------------------------------------------------
function TCaptureToFile.EndCaptureSession(): HRESULT;
var
  hr: HRESULT;

begin

  hr := S_OK;
  State := State_NotReady;
  EndCaptureInternal();

  if Assigned(m_pWriter) then
    hr := m_pWriter.Finalize();

  SafeRelease(m_pWriter);
  SafeRelease(m_pReader);

  Result := hr;
end;


function TCaptureToFile.IsCapturing(): BOOL;
var
  bIsCapturing: BOOL;

begin
  bIsCapturing := (m_pWriter <> nil) ;
  Result := bIsCapturing;
end;


//-------------------------------------------------------------------
//  CheckDeviceLost
//  Checks whether the video capture device was removed.
//
//  The application calls this method when it receives a
//  WM_DEVICECHANGE message.
//
//  Compare the device notification message against the symbolic link of your device, as follows:
//  1. Check the dbch_devicetype member of the DEV_BROADCAST_HDR structure.
//     If the value is DBT_DEVTYP_DEVICEINTERFACE, cast the structure pointer to a DEV_BROADCAST_DEVICEINTERFACE structure.
//  2. Compare the dbcc_name member of this structure to the symbolic link of the device.
//-------------------------------------------------------------------




// TDeviceList section /////////////////////////////////////////////////////////


constructor TDeviceList.Create();
begin
  inherited Create();
end;

// Before Destroy is called, release the interfaces.
procedure TDeviceList.BeforeDestruction();
begin
  Clear();
  inherited;
end;

// Caller should call Release.
destructor TDeviceList.Destroy();
begin
  inherited;
end;


procedure TDeviceList.Clear();
begin
  // Release the pointer to array
  CoTaskMemFree(m_ppDevices);
  m_ppDevices := nil;
  m_cDevices := 0;
end;


function TDeviceList.Count(): UINT32;
begin
  Result := m_cDevices;
end;


function TDeviceList.EnumerateDevices(): HRESULT;
var
  hr: HRESULT;
  pAttributes: IMFAttributes;

begin

  Clear();

  // Initialize an attribute store. We will use this to
  // specify the enumeration parameters.

  hr := MFCreateAttributes(pAttributes,
                           1);

  // Ask for source type = video capture devices
  if SUCCEEDED(hr) then
    hr := pAttributes.SetGUID(MF_DEVSOURCE_ATTRIBUTE_SOURCE_TYPE,
                              MF_DEVSOURCE_ATTRIBUTE_SOURCE_TYPE_VIDCAP_GUID);

  // Enumerate devices.

  if SUCCEEDED(hr) then
    begin
      hr := MFEnumDeviceSources(pAttributes, {in}
                                m_ppDevices, {out}
                                m_cDevices); {out}
    end;
  Result := hr;
end;


//
function TDeviceList.GetDevice(const index: UINT32;
                               out ppActivate: IMFActivate): HRESULT;
begin

  if (index >= Count()) then
    begin
      Result := E_INVALIDARG;
      Exit;
    end;

{$POINTERMATH ON}

  ppActivate := m_ppDevices[index];


{$POINTERMATH OFF}
  Result :=  S_OK;
end;

//
function TDeviceList.GetDeviceName(const index: UINT32;
                                   out strName: string): HRESULT;
var
  hr: HRESULT;
  pcchLength: UINT32;
  ppszName: PWideChar;

label
  Done;

begin

  if (index >= Count()) then
    begin
      hr := E_INVALIDARG;
      goto Done;
    end;

{$POINTERMATH ON}
  hr := m_ppDevices[index].GetAllocatedString(MF_DEVSOURCE_ATTRIBUTE_FRIENDLY_NAME,
                                              ppszName,
                                              pcchLength);
{$POINTERMATH OFF}

  // Convert to string strName
  if SUCCEEDED(hr) then
    strName := WideCharToString(ppszName)
  else
    strName := 'Unknown';

done:
  Result := hr;
end;


function TDeviceList.GetDeviceSymLink(const index: UINT32;
                                      out ppszSymLink: PWideChar): HRESULT;
var
  hr: HRESULT;
  pcchLength: UINT32;

label
  Done;

begin

  if (index >= Count()) then
    begin
      hr := E_INVALIDARG;
      goto Done;
    end;

{$POINTERMATH ON}
  hr:= m_ppDevices[index].GetAllocatedString(MF_DEVSOURCE_ATTRIBUTE_SOURCE_TYPE_VIDCAP_SYMBOLIC_LINK,
                                             ppszSymLink,
                                             pcchLength);
{$POINTERMATH OFF}

done:
  Result := hr;
end;


// End TDeviceList section /////////////////////////////////////////////////////

// Helpers /////////////////////////////////////////////////////////////////////

//------------------------------------------------------------------------------
//  ConfigureSourceReader
//
//  Sets the media type on the source reader.
//------------------------------------------------------------------------------
function ConfigureSourceReader(pReader: IMFSourceReader): HRESULT;
var
  hr: HRESULT;
  _i: Integer;
  bUseNativeType: BOOL;
  subtype: TGuid;
  pType: IMFMediaType;
  // The list of acceptable types.
 const subtypes : array[0..5] of ^Tguid = (@MFVideoFormat_NV12, @MFVideoFormat_YUY2, @MFVideoFormat_UYVY,
                                           @MFVideoFormat_RGB32, @MFVideoFormat_RGB24, @MFVideoFormat_IYUV);


label
  Done;

begin
  bUseNativeType := False;
  subtype := GUID_NULL;

  // If the source's native format matches any of the formats in
  // the list, prefer the native format.

  // Note: The camera might support multiple output formats,
  // including a range of frame dimensions. The application could
  // provide a list to the user and have the user select the
  // camera's output format. That is outside the scope of this
  // sample, however.
  // You may look in to the MFCaptureEngineVideoCapture sample on how to.

  hr := pReader.GetNativeMediaType(DWORD(MF_SOURCE_READER_FIRST_VIDEO_STREAM),
                                   0,  // Type index
                                   pType);

  if FAILED(hr) then
    goto Done;

  hr := pType.GetGUID(MF_MT_SUBTYPE,
                      subtype);

  if FAILED(hr) then
    goto Done;
    // The list of acceptable types.
    // MFVideoFormat_NV12, MFVideoFormat_YUY2, MFVideoFormat_UYVY,
    // MFVideoFormat_RGB32, MFVideoFormat_RGB24, MFVideoFormat_IYUV);


  for _i := 0 to SizeOf(subtypes) - 1 do
    begin
      if IsEqualGuid(subtype, subtypes[_i]^) then
        begin
          hr := pReader.SetCurrentMediaType(DWORD(MF_SOURCE_READER_FIRST_VIDEO_STREAM),
                                            0,
                                            pType);

          bUseNativeType := True;
          Break;
        end;
    end;

  if (bUseNativeType = True) then
    begin
      // None of the native types worked. The camera might offer
      // output a compressed type such as MJPEG or DV.

      // Try adding a decoder.
      for _i := 0 to Length(subtypes) - 1 do
        begin
            hr := pType.SetGUID(MF_MT_SUBTYPE,
                                subtypes[_i]^);

            if FAILED(hr) then
              Break;

            hr := pReader.SetCurrentMediaType(DWORD(MF_SOURCE_READER_FIRST_VIDEO_STREAM),
                                              0,
                                              pType);

            if SUCCEEDED(hr) then
              Break;
        end;
    end;

done:
    Result:= hr;
end;


function ConfigureEncoder(const params: EncodingParameters;
                          pType: IMFMediaType;
                          pWriter: IMFSinkWriter;
                          pdwStreamIndex: DWORD): HRESULT;
var
  hr: HRESULT;
  pType2: IMFMediaType;


begin

  hr := MFCreateMediaType(pType2);

  if SUCCEEDED(hr) then
    hr := pType2.SetGUID(MF_MT_MAJOR_TYPE,
                         MFMediaType_Video);

  if SUCCEEDED(hr) then
    hr := pType2.SetGUID(MF_MT_SUBTYPE,
                         params.subtype);

  if SUCCEEDED(hr) then
    hr := pType2.SetUINT32(MF_MT_AVG_BITRATE,
                           params.bitrate);

  if SUCCEEDED(hr) then
    hr := CopyAttribute(pType,
                        pType2,
                        MF_MT_FRAME_SIZE);

  if SUCCEEDED(hr) then
    hr := CopyAttribute(pType,
                        pType2,
                        MF_MT_FRAME_RATE);

  if SUCCEEDED(hr) then
    hr := CopyAttribute(pType,
                        pType2,
                        MF_MT_PIXEL_ASPECT_RATIO);

  if SUCCEEDED(hr) then
    hr := CopyAttribute(pType,
                        pType2,
                        MF_MT_INTERLACE_MODE);

  if SUCCEEDED(hr) then
    hr := pWriter.AddStream(pType2,
                            pdwStreamIndex);

  Result := hr;
end;


//------------------------------------------------------------------------------
// CopyAttribute
//
// Copy an attribute value from one attribute store to another.
//------------------------------------------------------------------------------
function CopyAttribute(pSrc: IMFAttributes;
                       pDest: IMFAttributes;
                       const key: REFGUID): HRESULT;
var
  hr: HRESULT;
  pvar: PROPVARIANT;  // Don't use the ActiveX one, the ActiveX PROPVARIANT is Delphi version depended!

begin

  PropVariantInit(pvar);

  hr := pSrc.GetItem(key,
                     pvar);

  if SUCCEEDED(hr) then
    hr := pDest.SetItem(key,
                        pvar);

  PropVariantClear(pvar);
  Result := hr;
end;



// End Helpers /////////////////////////////////////////////////////////////////



// initialization and  finalizationsection /////////////////////////////////////

initialization

  // Initialize the COM library
  CoInitializeEx(nil,
                 COINIT_APARTMENTTHREADED or COINIT_DISABLE_OLE1DDE);

  // Possible values are: MfStarted, MfStopped
  MfStatus:= MfStopped;

  // Initialize Media Foundation
  if FAILED(MFStartup(MF_VERSION, MFSTARTUP_FULL)) then
    begin
      MessageBox(0,
                 lpcwstr('Your computer does not support this Media Foundation API version' +
                         IntToStr(MF_VERSION) + '.'),
                 lpcwstr('MFStartup Failure!'),
                 MB_ICONSTOP);
      Abort;
    end;

  MfStatus:= MfStarted;

finalization
  // See BeforeDestruction.

end.
