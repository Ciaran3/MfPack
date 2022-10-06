// FactoryX
//
// Copyright: � FactoryX. All rights reserved.
//
// Project: MfPack - Media Foundation
// Project location: https://sourceforge.net/projects/MfPack
//                   https://github.com/FactoryXCode/MfPack
// Module: WinApi.DirectX.D3D12SDKLayers.pas
// Kind: Pascal / Delphi unit
// Release date: 13-08-2022
// Language: ENU
//
// Revision Version: 3.1.3
// Description: This header is used by Direct3D 12 Graphics.
//              See: https://learn.microsoft.com/en-us/windows/win32/api/_direct3d12/
//
// Organisation: FactoryX
// Initiator(s): Tony (maXcomX), Peter (OzShips)
// Contributor(s): Tony (maXcomX).
//
//------------------------------------------------------------------------------
// CHANGE LOG
// Date       Person              Reason
// ---------- ------------------- ----------------------------------------------
// 28/08/2022 All                 PiL release  SDK 10.0.22621.0 (Windows 11)
//------------------------------------------------------------------------------
//
// Remarks: Embarcadero's <= Delphi 10.4 D3D12 is outdated!
//
// Related objects: -
// Related projects: MfPackX313
// Known Issues: -
//
// Compiler version: 23 up to 35
// SDK version: 10.0.22621.0
//
// Todo: -
//
//==============================================================================
// Source: d3d12sdklayers.h
//
// Copyright (c) Microsoft Corporation. Licensed under the MIT license.
//==============================================================================
//
// LICENSE
//
//  The contents of this file are subject to the
//  GNU General Public License v3.0 (the "License");
//  you may not use this file except in
//  compliance with the License. You may obtain a copy of the License at
//  https://www.gnu.org/licenses/gpl-3.0.html
//
// Software distributed under the License is distributed on an "AS IS"
// basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
// License for the specific language governing rights and limitations
// under the License.
//
// Users may distribute this source code provided that this header is included
// in full at the top of the file.
//
//==============================================================================

unit WinApi.DirectX.D3D12SDKLayers;

interface

  {$HPPEMIT '#include "windows.h"'}
  {$HPPEMIT '#include "d3d12sdklayers.h"'}
  {$HPPEMIT '#include "d3d12.h"'}

uses
  {WinApi}
  WinApi.Windows,
  WinApi.WinApiTypes,
  {DirectX}
  WinApi.DirectX.D3D12;

  {$WEAKPACKAGEUNIT}
  {$MINENUMSIZE 4}
  {$IFDEF WIN32}
    {$ALIGN 1}
  {$ELSE}
    {$ALIGN 8} // Win64
  {$ENDIF}

  {$I 'WinApiTypes.inc'}

type

  //============================================================================
  //
  // Debugging Layer
  //
  //============================================================================

  // Interface ID3D12Debug
  // ======================
  // An interface used to turn on the debug layer.
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D12Debug);'}
  {$EXTERNALSYM ID3D12Debug}
  ID3D12Debug = Interface(IUnknown)
    ['{344488b7-6846-474b-b989-f027448245e0}']

    procedure EnableDebugLayer(); stdcall;

  end;
  IID_ID3D12Debug = ID3D12Debug;
  {$EXTERNALSYM IID_ID3D12Debug}

type
  PD3D12_GPU_BASED_VALIDATION_FLAGS = ^D3D12_GPU_BASED_VALIDATION_FLAGS;
  D3D12_GPU_BASED_VALIDATION_FLAGS = UINT;
  {$EXTERNALSYM D3D12_GPU_BASED_VALIDATION_FLAGS}
const
    D3D12_GPU_BASED_VALIDATION_FLAGS_NONE                   = D3D12_GPU_BASED_VALIDATION_FLAGS($00);
    {$EXTERNALSYM D3D12_GPU_BASED_VALIDATION_FLAGS_NONE}
    D3D12_GPU_BASED_VALIDATION_FLAGS_DISABLE_STATE_TRACKING = D3D12_GPU_BASED_VALIDATION_FLAGS($01);
    {$EXTERNALSYM D3D12_GPU_BASED_VALIDATION_FLAGS_DISABLE_STATE_TRACKING}


type

  // Interface ID3D12Debug1
  // =======================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D12Debug1);'}
  {$EXTERNALSYM ID3D12Debug1}
  ID3D12Debug1 = Interface(IUnknown)
    ['{affaa4ca-63fe-4d8e-b8ad-159000af4304}']

    procedure EnableDebugLayer(); stdcall;

    procedure SetEnableGPUBasedValidation(Enable: BOOL); stdcall;

    procedure SetEnableSynchronizedCommandQueueValidation(Enable: BOOL); stdcall;

  end;
  IID_ID3D12Debug1 = ID3D12Debug1;
  {$EXTERNALSYM IID_ID3D12Debug1}


  // Interface ID3D12Debug2
  // =======================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D12Debug2);'}
  {$EXTERNALSYM ID3D12Debug2}
  ID3D12Debug2 = Interface(IUnknown)
    ['{93a665c4-a3b2-4e5d-b692-a26ae14e3374}']

    procedure SetGPUBasedValidationFlags(Flags: D3D12_GPU_BASED_VALIDATION_FLAGS);

  end;
  IID_ID3D12Debug2 = ID3D12Debug2;
  {$EXTERNALSYM IID_ID3D12Debug2}


  // Interface ID3D12Debug3
  // =======================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D12Debug3);'}
  {$EXTERNALSYM ID3D12Debug3}
  ID3D12Debug3 = Interface(ID3D12Debug)
    ['{5cf4e58f-f671-4ff1-a542-3686e3d153d1}']

    procedure SetEnableGPUBasedValidation(Enable: BOOL);

    procedure SetEnableSynchronizedCommandQueueValidation(Enable: BOOL);

    procedure SetGPUBasedValidationFlags(Flags: D3D12_GPU_BASED_VALIDATION_FLAGS);

  end;
  IID_ID3D12Debug3 = ID3D12Debug3;
  {$EXTERNALSYM IID_ID3D12Debug3}


  // Interface ID3D12Debug4
  // =======================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D12Debug4);'}
  {$EXTERNALSYM ID3D12Debug4}
  ID3D12Debug4 = Interface(ID3D12Debug3)
    ['{014b816e-9ec5-4a2f-a845-ffbe441ce13a}']

    procedure DisableDebugLayer();

  end;
  IID_ID3D12Debug4 = ID3D12Debug4;
  {$EXTERNALSYM IID_ID3D12Debug4}


  // Interface ID3D12Debug5
  // =======================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D12Debug5);'}
  {$EXTERNALSYM ID3D12Debug5}
  ID3D12Debug5 = Interface(ID3D12Debug4)
    ['{548d6b12-09fa-40e0-9069-5dcd589a52c9}']

    procedure SetEnableAutoName(Enable: BOOL);

  end;
  IID_ID3D12Debug5 = ID3D12Debug5;
  {$EXTERNALSYM IID_ID3D12Debug5}


  // Interface ID3D12Debug6
  // =======================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D12Debug6);'}
  {$EXTERNALSYM ID3D12Debug6}
  ID3D12Debug6 = Interface(ID3D12Debug5)
    ['{82a816d6-5d01-4157-97d0-4975463fd1ed}']

    procedure SetForceLegacyBarrierValidation(Enable: BOOL);

  end;
  IID_ID3D12Debug6 = ID3D12Debug6;
  {$EXTERNALSYM IID_ID3D12Debug6}


const
  WKPDID_D3DAutoDebugObjectNameW  : TGUID = (D1: $d4902e36;
                                             D2: $757a;
                                             D3: $4942;
                                             D4: ($95, $94, $b6, $76, $9a, $fa, $43, $cd));


type
  PD3D12_RLDO_FLAGS = ^D3D12_RLDO_FLAGS;
  D3D12_RLDO_FLAGS = UINT;
  {$EXTERNALSYM D3D12_RLDO_FLAGS}
const
    D3D12_RLDO_NONE            = D3D12_RLDO_FLAGS($0);
    D3D12_RLDO_SUMMARY         = D3D12_RLDO_FLAGS($1);
    D3D12_RLDO_DETAIL          = D3D12_RLDO_FLAGS($2);
    D3D12_RLDO_IGNORE_INTERNAL = D3D12_RLDO_FLAGS($4);


type

  PD3D12_DEBUG_DEVICE_PARAMETER_TYPE = ^D3D12_DEBUG_DEVICE_PARAMETER_TYPE;
  D3D12_DEBUG_DEVICE_PARAMETER_TYPE = (
    D3D12_DEBUG_DEVICE_PARAMETER_FEATURE_FLAGS,
    D3D12_DEBUG_DEVICE_PARAMETER_GPU_BASED_VALIDATION_SETTINGS,
    D3D12_DEBUG_DEVICE_PARAMETER_GPU_SLOWDOWN_PERFORMANCE_FACTOR
  );
  {$EXTERNALSYM D3D12_DEBUG_DEVICE_PARAMETER_TYPE}


type
  PD3D12_DEBUG_FEATURE = ^D3D12_DEBUG_FEATURE;
  D3D12_DEBUG_FEATURE = UINT;
  {$EXTERNALSYM D3D12_DEBUG_FEATURE}
const
    D3D12_DEBUG_FEATURE_NONE                                   = D3D12_DEBUG_FEATURE($00);
    D3D12_DEBUG_FEATURE_ALLOW_BEHAVIOR_CHANGING_DEBUG_AIDS     = D3D12_DEBUG_FEATURE($01);
    D3D12_DEBUG_FEATURE_CONSERVATIVE_RESOURCE_STATE_TRACKING   = D3D12_DEBUG_FEATURE($02);
    D3D12_DEBUG_FEATURE_DISABLE_VIRTUALIZED_BUNDLES_VALIDATION = D3D12_DEBUG_FEATURE($04);
    D3D12_DEBUG_FEATURE_EMULATE_WINDOWS7                       = D3D12_DEBUG_FEATURE($08);


type

  PD3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODE = ^D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODE;
  D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODE = (
    D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODE_NONE,
    D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODE_STATE_TRACKING_ONLY,
    D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODE_UNGUARDED_VALIDATION,
    D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODE_GUARDED_VALIDATION,
    NUM_D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODES
  );
  {$EXTERNALSYM D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODE}


type
  PD3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAGS = ^D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAGS;
  D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAGS = UINT;
  {$EXTERNALSYM D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAGS}
const
    D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAG_NONE                                           = D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAGS($00);
    D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAG_FRONT_LOAD_CREATE_TRACKING_ONLY_SHADERS        = D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAGS($01);
    D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAG_FRONT_LOAD_CREATE_UNGUARDED_VALIDATION_SHADERS = D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAGS($02);
    D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAG_FRONT_LOAD_CREATE_GUARDED_VALIDATION_SHADERS   = D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAGS($04);
    D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAGS_VALID_MASK                                    = D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAGS($07);


type

  PD3D12_DEBUG_DEVICE_GPU_BASED_VALIDATION_SETTINGS = ^D3D12_DEBUG_DEVICE_GPU_BASED_VALIDATION_SETTINGS;
  D3D12_DEBUG_DEVICE_GPU_BASED_VALIDATION_SETTINGS = record
    MaxMessagesPerCommandList: UINT;
    DefaultShaderPatchMode: D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODE;
    PipelineStateCreateFlags: D3D12_GPU_BASED_VALIDATION_PIPELINE_STATE_CREATE_FLAGS;
  end;
  {$EXTERNALSYM D3D12_DEBUG_DEVICE_GPU_BASED_VALIDATION_SETTINGS}


  PD3D12_DEBUG_DEVICE_GPU_SLOWDOWN_PERFORMANCE_FACTOR = ^D3D12_DEBUG_DEVICE_GPU_SLOWDOWN_PERFORMANCE_FACTOR;
  D3D12_DEBUG_DEVICE_GPU_SLOWDOWN_PERFORMANCE_FACTOR = record
    SlowdownFactor: FLOAT;
  end;
  {$EXTERNALSYM D3D12_DEBUG_DEVICE_GPU_SLOWDOWN_PERFORMANCE_FACTOR}


  // Interface ID3D12DebugDevice1
  // =============================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D12DebugDevice1);'}
  {$EXTERNALSYM ID3D12DebugDevice1}
  ID3D12DebugDevice1 = Interface(IUnknown)
    ['{a9b71770-d099-4a65-a698-3dee10020f88}']

    function SetDebugParameter(Type_: D3D12_DEBUG_DEVICE_PARAMETER_TYPE;
                               pData: Pointer;
                               DataSize: UINT): HRESULT; stdcall;

    function GetDebugParameter(Type_: D3D12_DEBUG_DEVICE_PARAMETER_TYPE;
                               out pData: Pointer;
                               DataSize: UINT): HRESULT; stdcall;

    function ReportLiveDeviceObjects(Flags: D3D12_RLDO_FLAGS): HRESULT; stdcall;

  end;
  IID_ID3D12DebugDevice1 = ID3D12DebugDevice1;
  {$EXTERNALSYM IID_ID3D12DebugDevice1}


  // Interface ID3D12DebugDevice
  // ============================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D12DebugDevice);'}
  {$EXTERNALSYM ID3D12DebugDevice}
  ID3D12DebugDevice = Interface(IUnknown)
    ['{3febd6dd-4973-4787-8194-e45f9e28923e}']

    function SetFeatureMask(Mask: D3D12_DEBUG_FEATURE): HRESULT; stdcall;

    function GetFeatureMask(): D3D12_DEBUG_FEATURE; stdcall;

    function ReportLiveDeviceObjects(Flags: D3D12_RLDO_FLAGS): HRESULT; stdcall;

  end;
  IID_ID3D12DebugDevice = ID3D12DebugDevice;
  {$EXTERNALSYM IID_ID3D12DebugDevice}


  // Interface ID3D12DebugDevice2
  // =============================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D12DebugDevice2);'}
  {$EXTERNALSYM ID3D12DebugDevice2}
  ID3D12DebugDevice2 = Interface(ID3D12DebugDevice)
    ['{60eccbc1-378d-4df1-894c-f8ac5ce4d7dd}']

    function SetDebugParameter(Type_: D3D12_DEBUG_DEVICE_PARAMETER_TYPE;
                               pData: Pointer;
                               DataSize: UINT): HRESULT; stdcall;

    function GetDebugParameter(Type_: D3D12_DEBUG_DEVICE_PARAMETER_TYPE;
                               out pData: Pointer;
                               DataSize: UINT): HRESULT; stdcall;

  end;
  IID_ID3D12DebugDevice2 = ID3D12DebugDevice2;
  {$EXTERNALSYM IID_ID3D12DebugDevice2}


const
  DXGI_DEBUG_D3D12 : TGUID = (D1: $cf59a98c;
                              D2: $a950;
                              D3: $4326;
                              D4: ($91, $ef, $9b, $ba, $a1, $7b, $fd, $95));


type

  // Interface ID3D12DebugCommandQueue
  // ==================================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D12DebugCommandQueue);'}
  {$EXTERNALSYM ID3D12DebugCommandQueue}
  ID3D12DebugCommandQueue = Interface(IUnknown)
    ['{09e0bf36-54ac-484f-8847-4baeeab6053a}']

    function AssertResourceState(pResource: ID3D12Resource;
                                 SubResource: UINT;
                                 State: UINT): BOOL; stdcall;

    //  TODO: Stale  BOOL AssertResourceStateThroughView( [annotation("_In_")] ID3D12View* pView, UINT State );

  end;
  IID_ID3D12DebugCommandQueue = ID3D12DebugCommandQueue;
  {$EXTERNALSYM IID_ID3D12DebugCommandQueue}


  PD3D12_DEBUG_COMMAND_LIST_PARAMETER_TYPE = ^D3D12_DEBUG_COMMAND_LIST_PARAMETER_TYPE;
  D3D12_DEBUG_COMMAND_LIST_PARAMETER_TYPE = (
    D3D12_DEBUG_COMMAND_LIST_PARAMETER_GPU_BASED_VALIDATION_SETTINGS
  );
  {$EXTERNALSYM D3D12_DEBUG_COMMAND_LIST_PARAMETER_TYPE}


  PD3D12_DEBUG_COMMAND_LIST_GPU_BASED_VALIDATION_SETTINGS = ^D3D12_DEBUG_COMMAND_LIST_GPU_BASED_VALIDATION_SETTINGS;
  D3D12_DEBUG_COMMAND_LIST_GPU_BASED_VALIDATION_SETTINGS = record
    ShaderPatchMode: D3D12_GPU_BASED_VALIDATION_SHADER_PATCH_MODE;
  end;
  {$EXTERNALSYM D3D12_DEBUG_COMMAND_LIST_GPU_BASED_VALIDATION_SETTINGS}


  // Interface ID3D12DebugCommandList1
  // ==================================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D12DebugCommandList1);'}
  {$EXTERNALSYM ID3D12DebugCommandList1}
  ID3D12DebugCommandList1 = Interface(IUnknown)
    ['{102ca951-311b-4b01-b11f-ecb83e061b37}']

    function AssertResourceState(pResource: ID3D12Resource;
                                 Subresource: UINT;
                                 State: UINT): BOOL; stdcall;

    function SetDebugParameter(Type_: D3D12_DEBUG_COMMAND_LIST_PARAMETER_TYPE;
                               pData: Pointer;
                               DataSize: UINT): HRESULT; stdcall;

    function GetDebugParameter(Type_: D3D12_DEBUG_COMMAND_LIST_PARAMETER_TYPE;
                               out pData: Pointer;
                               DataSize: UINT): HRESULT; stdcall;

  end;
  IID_ID3D12DebugCommandList1 = ID3D12DebugCommandList1;
  {$EXTERNALSYM IID_ID3D12DebugCommandList1}


  // Interface ID3D12DebugCommandList
  // =================================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D12DebugCommandList);'}
  {$EXTERNALSYM ID3D12DebugCommandList}
  ID3D12DebugCommandList = Interface(IUnknown)
    ['{09e0bf36-54ac-484f-8847-4baeeab6053f}']

    function AssertResourceState(pResource: ID3D12Resource;
                                 Subresource: UINT;
                                 State: UINT): BOOL; stdcall;

    function SetFeatureMask(Mask: D3D12_DEBUG_FEATURE): HRESULT; stdcall;

    function GetFeatureMask(): D3D12_DEBUG_FEATURE; stdcall;

  end;
  IID_ID3D12DebugCommandList = ID3D12DebugCommandList;
  {$EXTERNALSYM IID_ID3D12DebugCommandList}


  // Interface ID3D12DebugCommandList2
  // ==================================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D12DebugCommandList2);'}
  {$EXTERNALSYM ID3D12DebugCommandList2}
  ID3D12DebugCommandList2 = Interface(ID3D12DebugCommandList)
    ['{aeb575cf-4e06-48be-ba3b-c450fc96652e}']

    function SetDebugParameter(Type_: D3D12_DEBUG_COMMAND_LIST_PARAMETER_TYPE;
                               pData: Pointer;
                               DataSize: UINT): HRESULT; stdcall;

    function GetDebugParameter(Type_: D3D12_DEBUG_COMMAND_LIST_PARAMETER_TYPE;
                               out pData: Pointer;
                               DataSize: UINT): HRESULT; stdcall;

  end;
  IID_ID3D12DebugCommandList2 = ID3D12DebugCommandList2;
  {$EXTERNALSYM IID_ID3D12DebugCommandList2}


  // Interface ID3D12SharingContract
  // ================================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D12SharingContract);'}
  {$EXTERNALSYM ID3D12SharingContract}
  ID3D12SharingContract = Interface(IUnknown)
    ['{0adf7d52-929c-4e61-addb-ffed30de66ef}']

    procedure Present(pResource: ID3D12Resource;
                      Subresource: UINT;
                      window: HWND); stdcall;

    procedure SharedFenceSignal(pFence: ID3D12Fence;
                                FenceValue: UINT64); stdcall;

    procedure BeginCapturableWork(const guid: REFGUID); stdcall;

    procedure EndCapturableWork(const guid: REFGUID); stdcall;

  end;
  IID_ID3D12SharingContract = ID3D12SharingContract;
  {$EXTERNALSYM IID_ID3D12SharingContract}


  //============================================================================
  //
  // Info Queue
  //
  //============================================================================

  PD3D12_MESSAGE_CATEGORY = ^D3D12_MESSAGE_CATEGORY;
  D3D12_MESSAGE_CATEGORY = (
    D3D12_MESSAGE_CATEGORY_APPLICATION_DEFINED,
    D3D12_MESSAGE_CATEGORY_MISCELLANEOUS,
    D3D12_MESSAGE_CATEGORY_INITIALIZATION,
    D3D12_MESSAGE_CATEGORY_CLEANUP,
    D3D12_MESSAGE_CATEGORY_COMPILATION,
    D3D12_MESSAGE_CATEGORY_STATE_CREATION,
    D3D12_MESSAGE_CATEGORY_STATE_SETTING,
    D3D12_MESSAGE_CATEGORY_STATE_GETTING,
    D3D12_MESSAGE_CATEGORY_RESOURCE_MANIPULATION,
    D3D12_MESSAGE_CATEGORY_EXECUTION,
    D3D12_MESSAGE_CATEGORY_SHADER
  );
  {$EXTERNALSYM D3D12_MESSAGE_CATEGORY}


  PD3D12_MESSAGE_SEVERITY = ^D3D12_MESSAGE_SEVERITY;
  D3D12_MESSAGE_SEVERITY = (
    D3D12_MESSAGE_SEVERITY_CORRUPTION,
    D3D12_MESSAGE_SEVERITY_ERROR,
    D3D12_MESSAGE_SEVERITY_WARNING,
    D3D12_MESSAGE_SEVERITY_INFO,
    D3D12_MESSAGE_SEVERITY_MESSAGE
  );
  {$EXTERNALSYM D3D12_MESSAGE_SEVERITY}


  // Unique ID for every error
  // CAUTION: New enum values should be appended to the list only.  Inserting
  // new enum values into the middle of the list results in changing the numeric
  // values of some ID's from one SDK release to the next.  This in-turn breaks
  // PIX and customer tools/filters.
  PD3D12_MESSAGE_ID = ^D3D12_MESSAGE_ID;
  D3D12_MESSAGE_ID                                                                                                 = (
    D3D12_MESSAGE_ID_UNKNOWN                                                                                       = 0,
    //--------------------------------------------------------------------------
    // Messages Used by Core
    // Message IDs generated from core are at the beginning
    // since the core changes less frequently than the debug layer.
    // End of Messages used by Core
    // ------------------------------------------------------------------------
    D3D12_MESSAGE_ID_STRING_FROM_APPLICATION                                                                       = 1,
    D3D12_MESSAGE_ID_CORRUPTED_THIS                                                                                = 2,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER1                                                                          = 3,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER2                                                                          = 4,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER3                                                                          = 5,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER4                                                                          = 6,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER5                                                                          = 7,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER6                                                                          = 8,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER7                                                                          = 9,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER8                                                                          = 10,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER9                                                                          = 11,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER10                                                                         = 12,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER11                                                                         = 13,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER12                                                                         = 14,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER13                                                                         = 15,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER14                                                                         = 16,
    D3D12_MESSAGE_ID_CORRUPTED_PARAMETER15                                                                         = 17,
    D3D12_MESSAGE_ID_CORRUPTED_MULTITHREADING                                                                      = 18,
    D3D12_MESSAGE_ID_MESSAGE_REPORTING_OUTOFMEMORY                                                                 = 19,
    D3D12_MESSAGE_ID_GETPRIVATEDATA_MOREDATA                                                                       = 20,
    D3D12_MESSAGE_ID_SETPRIVATEDATA_INVALIDFREEDATA                                                                = 21,
    D3D12_MESSAGE_ID_SETPRIVATEDATA_CHANGINGPARAMS                                                                 = 24,
    D3D12_MESSAGE_ID_SETPRIVATEDATA_OUTOFMEMORY                                                                    = 25,
    D3D12_MESSAGE_ID_CREATESHADERRESOURCEVIEW_UNRECOGNIZEDFORMAT                                                   = 26,
    D3D12_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDDESC                                                          = 27,
    D3D12_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDFORMAT                                                        = 28,
    D3D12_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDVIDEOPLANESLICE                                               = 29,
    D3D12_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDPLANESLICE                                                    = 30,
    D3D12_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDDIMENSIONS                                                    = 31,
    D3D12_MESSAGE_ID_CREATESHADERRESOURCEVIEW_INVALIDRESOURCE                                                      = 32,
    D3D12_MESSAGE_ID_CREATERENDERTARGETVIEW_UNRECOGNIZEDFORMAT                                                     = 35,
    D3D12_MESSAGE_ID_CREATERENDERTARGETVIEW_UNSUPPORTEDFORMAT                                                      = 36,
    D3D12_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDDESC                                                            = 37,
    D3D12_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDFORMAT                                                          = 38,
    D3D12_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDVIDEOPLANESLICE                                                 = 39,
    D3D12_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDPLANESLICE                                                      = 40,
    D3D12_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDDIMENSIONS                                                      = 41,
    D3D12_MESSAGE_ID_CREATERENDERTARGETVIEW_INVALIDRESOURCE                                                        = 42,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_UNRECOGNIZEDFORMAT                                                     = 45,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDDESC                                                            = 46,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDFORMAT                                                          = 47,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDDIMENSIONS                                                      = 48,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDRESOURCE                                                        = 49,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_OUTOFMEMORY                                                                 = 52,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_TOOMANYELEMENTS                                                             = 53,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDFORMAT                                                               = 54,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_INCOMPATIBLEFORMAT                                                          = 55,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSLOT                                                                 = 56,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDINPUTSLOTCLASS                                                       = 57,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_STEPRATESLOTCLASSMISMATCH                                                   = 58,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSLOTCLASSCHANGE                                                      = 59,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDSTEPRATECHANGE                                                       = 60,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_INVALIDALIGNMENT                                                            = 61,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_DUPLICATESEMANTIC                                                           = 62,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_UNPARSEABLEINPUTSIGNATURE                                                   = 63,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_NULLSEMANTIC                                                                = 64,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_MISSINGELEMENT                                                              = 65,
    D3D12_MESSAGE_ID_CREATEVERTEXSHADER_OUTOFMEMORY                                                                = 66,
    D3D12_MESSAGE_ID_CREATEVERTEXSHADER_INVALIDSHADERBYTECODE                                                      = 67,
    D3D12_MESSAGE_ID_CREATEVERTEXSHADER_INVALIDSHADERTYPE                                                          = 68,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADER_OUTOFMEMORY                                                              = 69,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADER_INVALIDSHADERBYTECODE                                                    = 70,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADER_INVALIDSHADERTYPE                                                        = 71,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTOFMEMORY                                              = 72,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSHADERBYTECODE                                    = 73,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSHADERTYPE                                        = 74,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDNUMENTRIES                                        = 75,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTPUTSTREAMSTRIDEUNUSED                                 = 76,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_OUTPUTSLOT0EXPECTED                                      = 79,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDOUTPUTSLOT                                        = 80,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_ONLYONEELEMENTPERSLOT                                    = 81,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDCOMPONENTCOUNT                                    = 82,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSTARTCOMPONENTANDCOMPONENTCOUNT                   = 83,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDGAPDEFINITION                                     = 84,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_REPEATEDOUTPUT                                           = 85,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDOUTPUTSTREAMSTRIDE                                = 86,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MISSINGSEMANTIC                                          = 87,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MASKMISMATCH                                             = 88,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_CANTHAVEONLYGAPS                                         = 89,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_DECLTOOCOMPLEX                                           = 90,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_MISSINGOUTPUTSIGNATURE                                   = 91,
    D3D12_MESSAGE_ID_CREATEPIXELSHADER_OUTOFMEMORY                                                                 = 92,
    D3D12_MESSAGE_ID_CREATEPIXELSHADER_INVALIDSHADERBYTECODE                                                       = 93,
    D3D12_MESSAGE_ID_CREATEPIXELSHADER_INVALIDSHADERTYPE                                                           = 94,
    D3D12_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDFILLMODE                                                         = 95,
    D3D12_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDCULLMODE                                                         = 96,
    D3D12_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDDEPTHBIASCLAMP                                                   = 97,
    D3D12_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDSLOPESCALEDDEPTHBIAS                                             = 98,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDDEPTHWRITEMASK                                                 = 100,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDDEPTHFUNC                                                      = 101,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILFAILOP                                         = 102,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILZFAILOP                                        = 103,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILPASSOP                                         = 104,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDFRONTFACESTENCILFUNC                                           = 105,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILFAILOP                                          = 106,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILZFAILOP                                         = 107,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILPASSOP                                          = 108,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_INVALIDBACKFACESTENCILFUNC                                            = 109,
    D3D12_MESSAGE_ID_CREATEBLENDSTATE_INVALIDSRCBLEND                                                              = 111,
    D3D12_MESSAGE_ID_CREATEBLENDSTATE_INVALIDDESTBLEND                                                             = 112,
    D3D12_MESSAGE_ID_CREATEBLENDSTATE_INVALIDBLENDOP                                                               = 113,
    D3D12_MESSAGE_ID_CREATEBLENDSTATE_INVALIDSRCBLENDALPHA                                                         = 114,
    D3D12_MESSAGE_ID_CREATEBLENDSTATE_INVALIDDESTBLENDALPHA                                                        = 115,
    D3D12_MESSAGE_ID_CREATEBLENDSTATE_INVALIDBLENDOPALPHA                                                          = 116,
    D3D12_MESSAGE_ID_CREATEBLENDSTATE_INVALIDRENDERTARGETWRITEMASK                                                 = 117,
    D3D12_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_INVALID                                                                 = 135,
    D3D12_MESSAGE_ID_COMMAND_LIST_DRAW_ROOT_SIGNATURE_NOT_SET                                                      = 200,
    D3D12_MESSAGE_ID_COMMAND_LIST_DRAW_ROOT_SIGNATURE_MISMATCH                                                     = 201,
    D3D12_MESSAGE_ID_COMMAND_LIST_DRAW_VERTEX_BUFFER_NOT_SET                                                       = 202,
    D3D12_MESSAGE_ID_COMMAND_LIST_DRAW_VERTEX_BUFFER_STRIDE_TOO_SMALL                                              = 209,
    D3D12_MESSAGE_ID_COMMAND_LIST_DRAW_VERTEX_BUFFER_TOO_SMALL                                                     = 210,
    D3D12_MESSAGE_ID_COMMAND_LIST_DRAW_INDEX_BUFFER_NOT_SET                                                        = 211,
    D3D12_MESSAGE_ID_COMMAND_LIST_DRAW_INDEX_BUFFER_FORMAT_INVALID                                                 = 212,
    D3D12_MESSAGE_ID_COMMAND_LIST_DRAW_INDEX_BUFFER_TOO_SMALL                                                      = 213,
    D3D12_MESSAGE_ID_COMMAND_LIST_DRAW_INVALID_PRIMITIVETOPOLOGY                                                   = 219,
    D3D12_MESSAGE_ID_COMMAND_LIST_DRAW_VERTEX_STRIDE_UNALIGNED                                                     = 221,
    D3D12_MESSAGE_ID_COMMAND_LIST_DRAW_INDEX_OFFSET_UNALIGNED                                                      = 222,
    D3D12_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_AT_FAULT                                                               = 232,
    D3D12_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_POSSIBLY_AT_FAULT                                                      = 233,
    D3D12_MESSAGE_ID_DEVICE_REMOVAL_PROCESS_NOT_AT_FAULT                                                           = 234,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_TRAILING_DIGIT_IN_SEMANTIC                                                  = 239,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_TRAILING_DIGIT_IN_SEMANTIC                               = 240,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_TYPE_MISMATCH                                                               = 245,
    D3D12_MESSAGE_ID_CREATEINPUTLAYOUT_EMPTY_LAYOUT                                                                = 253,
    D3D12_MESSAGE_ID_LIVE_OBJECT_SUMMARY                                                                           = 255,
    D3D12_MESSAGE_ID_LIVE_DEVICE                                                                                   = 274,
    D3D12_MESSAGE_ID_LIVE_SWAPCHAIN                                                                                = 275,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILVIEW_INVALIDFLAGS                                                           = 276,
    D3D12_MESSAGE_ID_CREATEVERTEXSHADER_INVALIDCLASSLINKAGE                                                        = 277,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADER_INVALIDCLASSLINKAGE                                                      = 278,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSTREAMTORASTERIZER                                = 280,
    D3D12_MESSAGE_ID_CREATEPIXELSHADER_INVALIDCLASSLINKAGE                                                         = 283,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDSTREAM                                            = 284,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UNEXPECTEDENTRIES                                        = 285,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UNEXPECTEDSTRIDES                                        = 286,
    D3D12_MESSAGE_ID_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_INVALIDNUMSTRIDES                                        = 287,
    D3D12_MESSAGE_ID_CREATEHULLSHADER_OUTOFMEMORY                                                                  = 289,
    D3D12_MESSAGE_ID_CREATEHULLSHADER_INVALIDSHADERBYTECODE                                                        = 290,
    D3D12_MESSAGE_ID_CREATEHULLSHADER_INVALIDSHADERTYPE                                                            = 291,
    D3D12_MESSAGE_ID_CREATEHULLSHADER_INVALIDCLASSLINKAGE                                                          = 292,
    D3D12_MESSAGE_ID_CREATEDOMAINSHADER_OUTOFMEMORY                                                                = 294,
    D3D12_MESSAGE_ID_CREATEDOMAINSHADER_INVALIDSHADERBYTECODE                                                      = 295,
    D3D12_MESSAGE_ID_CREATEDOMAINSHADER_INVALIDSHADERTYPE                                                          = 296,
    D3D12_MESSAGE_ID_CREATEDOMAINSHADER_INVALIDCLASSLINKAGE                                                        = 297,
    D3D12_MESSAGE_ID_RESOURCE_UNMAP_NOTMAPPED                                                                      = 310,
    D3D12_MESSAGE_ID_DEVICE_CHECKFEATURESUPPORT_MISMATCHED_DATA_SIZE                                               = 318,
    D3D12_MESSAGE_ID_CREATECOMPUTESHADER_OUTOFMEMORY                                                               = 321,
    D3D12_MESSAGE_ID_CREATECOMPUTESHADER_INVALIDSHADERBYTECODE                                                     = 322,
    D3D12_MESSAGE_ID_CREATECOMPUTESHADER_INVALIDCLASSLINKAGE                                                       = 323,
    D3D12_MESSAGE_ID_DEVICE_CREATEVERTEXSHADER_DOUBLEFLOATOPSNOTSUPPORTED                                          = 331,
    D3D12_MESSAGE_ID_DEVICE_CREATEHULLSHADER_DOUBLEFLOATOPSNOTSUPPORTED                                            = 332,
    D3D12_MESSAGE_ID_DEVICE_CREATEDOMAINSHADER_DOUBLEFLOATOPSNOTSUPPORTED                                          = 333,
    D3D12_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADER_DOUBLEFLOATOPSNOTSUPPORTED                                        = 334,
    D3D12_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_DOUBLEFLOATOPSNOTSUPPORTED                        = 335,
    D3D12_MESSAGE_ID_DEVICE_CREATEPIXELSHADER_DOUBLEFLOATOPSNOTSUPPORTED                                           = 336,
    D3D12_MESSAGE_ID_DEVICE_CREATECOMPUTESHADER_DOUBLEFLOATOPSNOTSUPPORTED                                         = 337,
    D3D12_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDRESOURCE                                                     = 340,
    D3D12_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDDESC                                                         = 341,
    D3D12_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDFORMAT                                                       = 342,
    D3D12_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDVIDEOPLANESLICE                                              = 343,
    D3D12_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDPLANESLICE                                                   = 344,
    D3D12_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDDIMENSIONS                                                   = 345,
    D3D12_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_UNRECOGNIZEDFORMAT                                                  = 346,
    D3D12_MESSAGE_ID_CREATEUNORDEREDACCESSVIEW_INVALIDFLAGS                                                        = 354,
    D3D12_MESSAGE_ID_CREATERASTERIZERSTATE_INVALIDFORCEDSAMPLECOUNT                                                = 401,
    D3D12_MESSAGE_ID_CREATEBLENDSTATE_INVALIDLOGICOPS                                                              = 403,
    D3D12_MESSAGE_ID_DEVICE_CREATEVERTEXSHADER_DOUBLEEXTENSIONSNOTSUPPORTED                                        = 410,
    D3D12_MESSAGE_ID_DEVICE_CREATEHULLSHADER_DOUBLEEXTENSIONSNOTSUPPORTED                                          = 412,
    D3D12_MESSAGE_ID_DEVICE_CREATEDOMAINSHADER_DOUBLEEXTENSIONSNOTSUPPORTED                                        = 414,
    D3D12_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADER_DOUBLEEXTENSIONSNOTSUPPORTED                                      = 416,
    D3D12_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_DOUBLEEXTENSIONSNOTSUPPORTED                      = 418,
    D3D12_MESSAGE_ID_DEVICE_CREATEPIXELSHADER_DOUBLEEXTENSIONSNOTSUPPORTED                                         = 420,
    D3D12_MESSAGE_ID_DEVICE_CREATECOMPUTESHADER_DOUBLEEXTENSIONSNOTSUPPORTED                                       = 422,
    D3D12_MESSAGE_ID_DEVICE_CREATEVERTEXSHADER_UAVSNOTSUPPORTED                                                    = 425,
    D3D12_MESSAGE_ID_DEVICE_CREATEHULLSHADER_UAVSNOTSUPPORTED                                                      = 426,
    D3D12_MESSAGE_ID_DEVICE_CREATEDOMAINSHADER_UAVSNOTSUPPORTED                                                    = 427,
    D3D12_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADER_UAVSNOTSUPPORTED                                                  = 428,
    D3D12_MESSAGE_ID_DEVICE_CREATEGEOMETRYSHADERWITHSTREAMOUTPUT_UAVSNOTSUPPORTED                                  = 429,
    D3D12_MESSAGE_ID_DEVICE_CREATEPIXELSHADER_UAVSNOTSUPPORTED                                                     = 430,
    D3D12_MESSAGE_ID_DEVICE_CREATECOMPUTESHADER_UAVSNOTSUPPORTED                                                   = 431,
    D3D12_MESSAGE_ID_DEVICE_CLEARVIEW_INVALIDSOURCERECT                                                            = 447,
    D3D12_MESSAGE_ID_DEVICE_CLEARVIEW_EMPTYRECT                                                                    = 448,
    D3D12_MESSAGE_ID_UPDATETILEMAPPINGS_INVALID_PARAMETER                                                          = 493,
    D3D12_MESSAGE_ID_COPYTILEMAPPINGS_INVALID_PARAMETER                                                            = 494,
    D3D12_MESSAGE_ID_CREATEDEVICE_INVALIDARGS                                                                      = 506,
    D3D12_MESSAGE_ID_CREATEDEVICE_WARNING                                                                          = 507,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_INVALID_TYPE                                                                 = 519,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_NULL_POINTER                                                                 = 520,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_INVALID_SUBRESOURCE                                                          = 521,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_RESERVED_BITS                                                                = 522,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_MISSING_BIND_FLAGS                                                           = 523,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_MISMATCHING_MISC_FLAGS                                                       = 524,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_MATCHING_STATES                                                              = 525,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_INVALID_COMBINATION                                                          = 526,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_BEFORE_AFTER_MISMATCH                                                        = 527,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_INVALID_RESOURCE                                                             = 528,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_SAMPLE_COUNT                                                                 = 529,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_INVALID_FLAGS                                                                = 530,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_INVALID_COMBINED_FLAGS                                                       = 531,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_INVALID_FLAGS_FOR_FORMAT                                                     = 532,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_INVALID_SPLIT_BARRIER                                                        = 533,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_UNMATCHED_END                                                                = 534,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_UNMATCHED_BEGIN                                                              = 535,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_INVALID_FLAG                                                                 = 536,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_INVALID_COMMAND_LIST_TYPE                                                    = 537,
    D3D12_MESSAGE_ID_INVALID_SUBRESOURCE_STATE                                                                     = 538,
    D3D12_MESSAGE_ID_COMMAND_ALLOCATOR_CONTENTION                                                                  = 540,
    D3D12_MESSAGE_ID_COMMAND_ALLOCATOR_RESET                                                                       = 541,
    D3D12_MESSAGE_ID_COMMAND_ALLOCATOR_RESET_BUNDLE                                                                = 542,
    D3D12_MESSAGE_ID_COMMAND_ALLOCATOR_CANNOT_RESET                                                                = 543,
    D3D12_MESSAGE_ID_COMMAND_LIST_OPEN                                                                             = 544,
    D3D12_MESSAGE_ID_INVALID_BUNDLE_API                                                                            = 546,
    D3D12_MESSAGE_ID_COMMAND_LIST_CLOSED                                                                           = 547,
    D3D12_MESSAGE_ID_WRONG_COMMAND_ALLOCATOR_TYPE                                                                  = 549,
    D3D12_MESSAGE_ID_COMMAND_ALLOCATOR_SYNC                                                                        = 552,
    D3D12_MESSAGE_ID_COMMAND_LIST_SYNC                                                                             = 553,
    D3D12_MESSAGE_ID_SET_DESCRIPTOR_HEAP_INVALID                                                                   = 554,
    D3D12_MESSAGE_ID_CREATE_COMMANDQUEUE                                                                           = 557,
    D3D12_MESSAGE_ID_CREATE_COMMANDALLOCATOR                                                                       = 558,
    D3D12_MESSAGE_ID_CREATE_PIPELINESTATE                                                                          = 559,
    D3D12_MESSAGE_ID_CREATE_COMMANDLIST12                                                                          = 560,
    D3D12_MESSAGE_ID_CREATE_RESOURCE                                                                               = 562,
    D3D12_MESSAGE_ID_CREATE_DESCRIPTORHEAP                                                                         = 563,
    D3D12_MESSAGE_ID_CREATE_ROOTSIGNATURE                                                                          = 564,
    D3D12_MESSAGE_ID_CREATE_LIBRARY                                                                                = 565,
    D3D12_MESSAGE_ID_CREATE_HEAP                                                                                   = 566,
    D3D12_MESSAGE_ID_CREATE_MONITOREDFENCE                                                                         = 567,
    D3D12_MESSAGE_ID_CREATE_QUERYHEAP                                                                              = 568,
    D3D12_MESSAGE_ID_CREATE_COMMANDSIGNATURE                                                                       = 569,
    D3D12_MESSAGE_ID_LIVE_COMMANDQUEUE                                                                             = 570,
    D3D12_MESSAGE_ID_LIVE_COMMANDALLOCATOR                                                                         = 571,
    D3D12_MESSAGE_ID_LIVE_PIPELINESTATE                                                                            = 572,
    D3D12_MESSAGE_ID_LIVE_COMMANDLIST12                                                                            = 573,
    D3D12_MESSAGE_ID_LIVE_RESOURCE                                                                                 = 575,
    D3D12_MESSAGE_ID_LIVE_DESCRIPTORHEAP                                                                           = 576,
    D3D12_MESSAGE_ID_LIVE_ROOTSIGNATURE                                                                            = 577,
    D3D12_MESSAGE_ID_LIVE_LIBRARY                                                                                  = 578,
    D3D12_MESSAGE_ID_LIVE_HEAP                                                                                     = 579,
    D3D12_MESSAGE_ID_LIVE_MONITOREDFENCE                                                                           = 580,
    D3D12_MESSAGE_ID_LIVE_QUERYHEAP                                                                                = 581,
    D3D12_MESSAGE_ID_LIVE_COMMANDSIGNATURE                                                                         = 582,
    D3D12_MESSAGE_ID_DESTROY_COMMANDQUEUE                                                                          = 583,
    D3D12_MESSAGE_ID_DESTROY_COMMANDALLOCATOR                                                                      = 584,
    D3D12_MESSAGE_ID_DESTROY_PIPELINESTATE                                                                         = 585,
    D3D12_MESSAGE_ID_DESTROY_COMMANDLIST12                                                                         = 586,
    D3D12_MESSAGE_ID_DESTROY_RESOURCE                                                                              = 588,
    D3D12_MESSAGE_ID_DESTROY_DESCRIPTORHEAP                                                                        = 589,
    D3D12_MESSAGE_ID_DESTROY_ROOTSIGNATURE                                                                         = 590,
    D3D12_MESSAGE_ID_DESTROY_LIBRARY                                                                               = 591,
    D3D12_MESSAGE_ID_DESTROY_HEAP                                                                                  = 592,
    D3D12_MESSAGE_ID_DESTROY_MONITOREDFENCE                                                                        = 593,
    D3D12_MESSAGE_ID_DESTROY_QUERYHEAP                                                                             = 594,
    D3D12_MESSAGE_ID_DESTROY_COMMANDSIGNATURE                                                                      = 595,
    D3D12_MESSAGE_ID_CREATERESOURCE_INVALIDDIMENSIONS                                                              = 597,
    D3D12_MESSAGE_ID_CREATERESOURCE_INVALIDMISCFLAGS                                                               = 599,
    D3D12_MESSAGE_ID_CREATERESOURCE_INVALIDARG_RETURN                                                              = 602,
    D3D12_MESSAGE_ID_CREATERESOURCE_OUTOFMEMORY_RETURN                                                             = 603,
    D3D12_MESSAGE_ID_CREATERESOURCE_INVALIDDESC                                                                    = 604,
    // This was shipped, but is no longer used. Do not reuse.
    //D3D12_MESSAGE_ID_CREATERESOURCE_INVALIDINITIALSTATE                                                          = 605,
    D3D12_MESSAGE_ID_POSSIBLY_INVALID_SUBRESOURCE_STATE                                                            = 607,
    D3D12_MESSAGE_ID_INVALID_USE_OF_NON_RESIDENT_RESOURCE                                                          = 608,
    D3D12_MESSAGE_ID_POSSIBLE_INVALID_USE_OF_NON_RESIDENT_RESOURCE                                                 = 609,
    D3D12_MESSAGE_ID_BUNDLE_PIPELINE_STATE_MISMATCH                                                                = 610,
    D3D12_MESSAGE_ID_PRIMITIVE_TOPOLOGY_MISMATCH_PIPELINE_STATE                                                    = 611,
    D3D12_MESSAGE_ID_RENDER_TARGET_FORMAT_MISMATCH_PIPELINE_STATE                                                  = 613,
    D3D12_MESSAGE_ID_RENDER_TARGET_SAMPLE_DESC_MISMATCH_PIPELINE_STATE                                             = 614,
    D3D12_MESSAGE_ID_DEPTH_STENCIL_FORMAT_MISMATCH_PIPELINE_STATE                                                  = 615,
    D3D12_MESSAGE_ID_DEPTH_STENCIL_SAMPLE_DESC_MISMATCH_PIPELINE_STATE                                             = 616,
    D3D12_MESSAGE_ID_CREATESHADER_INVALIDBYTECODE                                                                  = 622,
    D3D12_MESSAGE_ID_CREATEHEAP_NULLDESC                                                                           = 623,
    D3D12_MESSAGE_ID_CREATEHEAP_INVALIDSIZE                                                                        = 624,
    D3D12_MESSAGE_ID_CREATEHEAP_UNRECOGNIZEDHEAPTYPE                                                               = 625,
    D3D12_MESSAGE_ID_CREATEHEAP_UNRECOGNIZEDCPUPAGEPROPERTIES                                                      = 626,
    D3D12_MESSAGE_ID_CREATEHEAP_UNRECOGNIZEDMEMORYPOOL                                                             = 627,
    D3D12_MESSAGE_ID_CREATEHEAP_INVALIDPROPERTIES                                                                  = 628,
    D3D12_MESSAGE_ID_CREATEHEAP_INVALIDALIGNMENT                                                                   = 629,
    D3D12_MESSAGE_ID_CREATEHEAP_UNRECOGNIZEDMISCFLAGS                                                              = 630,
    D3D12_MESSAGE_ID_CREATEHEAP_INVALIDMISCFLAGS                                                                   = 631,
    D3D12_MESSAGE_ID_CREATEHEAP_INVALIDARG_RETURN                                                                  = 632,
    D3D12_MESSAGE_ID_CREATEHEAP_OUTOFMEMORY_RETURN                                                                 = 633,
    D3D12_MESSAGE_ID_CREATERESOURCEANDHEAP_NULLHEAPPROPERTIES                                                      = 634,
    D3D12_MESSAGE_ID_CREATERESOURCEANDHEAP_UNRECOGNIZEDHEAPTYPE                                                    = 635,
    D3D12_MESSAGE_ID_CREATERESOURCEANDHEAP_UNRECOGNIZEDCPUPAGEPROPERTIES                                           = 636,
    D3D12_MESSAGE_ID_CREATERESOURCEANDHEAP_UNRECOGNIZEDMEMORYPOOL                                                  = 637,
    D3D12_MESSAGE_ID_CREATERESOURCEANDHEAP_INVALIDHEAPPROPERTIES                                                   = 638,
    D3D12_MESSAGE_ID_CREATERESOURCEANDHEAP_UNRECOGNIZEDHEAPMISCFLAGS                                               = 639,
    D3D12_MESSAGE_ID_CREATERESOURCEANDHEAP_INVALIDHEAPMISCFLAGS                                                    = 640,
    D3D12_MESSAGE_ID_CREATERESOURCEANDHEAP_INVALIDARG_RETURN                                                       = 641,
    D3D12_MESSAGE_ID_CREATERESOURCEANDHEAP_OUTOFMEMORY_RETURN                                                      = 642,
    D3D12_MESSAGE_ID_GETCUSTOMHEAPPROPERTIES_UNRECOGNIZEDHEAPTYPE                                                  = 643,
    D3D12_MESSAGE_ID_GETCUSTOMHEAPPROPERTIES_INVALIDHEAPTYPE                                                       = 644,
    D3D12_MESSAGE_ID_CREATE_DESCRIPTOR_HEAP_INVALID_DESC                                                           = 645,
    D3D12_MESSAGE_ID_INVALID_DESCRIPTOR_HANDLE                                                                     = 646,
    D3D12_MESSAGE_ID_CREATERASTERIZERSTATE_INVALID_CONSERVATIVERASTERMODE                                          = 647,
    D3D12_MESSAGE_ID_CREATE_CONSTANT_BUFFER_VIEW_INVALID_RESOURCE                                                  = 649,
    D3D12_MESSAGE_ID_CREATE_CONSTANT_BUFFER_VIEW_INVALID_DESC                                                      = 650,
    D3D12_MESSAGE_ID_CREATE_UNORDEREDACCESS_VIEW_INVALID_COUNTER_USAGE                                             = 652,
    D3D12_MESSAGE_ID_COPY_DESCRIPTORS_INVALID_RANGES                                                               = 653,
    D3D12_MESSAGE_ID_COPY_DESCRIPTORS_WRITE_ONLY_DESCRIPTOR                                                        = 654,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_RTV_FORMAT_NOT_UNKNOWN                                            = 655,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_INVALID_RENDER_TARGET_COUNT                                       = 656,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_VERTEX_SHADER_NOT_SET                                             = 657,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_INPUTLAYOUT_NOT_SET                                               = 658,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_SHADER_LINKAGE_HS_DS_SIGNATURE_MISMATCH                           = 659,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_SHADER_LINKAGE_REGISTERINDEX                                      = 660,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_SHADER_LINKAGE_COMPONENTTYPE                                      = 661,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_SHADER_LINKAGE_REGISTERMASK                                       = 662,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_SHADER_LINKAGE_SYSTEMVALUE                                        = 663,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_SHADER_LINKAGE_NEVERWRITTEN_ALWAYSREADS                           = 664,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_SHADER_LINKAGE_MINPRECISION                                       = 665,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_SHADER_LINKAGE_SEMANTICNAME_NOT_FOUND                             = 666,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_HS_XOR_DS_MISMATCH                                                = 667,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_HULL_SHADER_INPUT_TOPOLOGY_MISMATCH                               = 668,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_HS_DS_CONTROL_POINT_COUNT_MISMATCH                                = 669,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_HS_DS_TESSELLATOR_DOMAIN_MISMATCH                                 = 670,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_INVALID_USE_OF_CENTER_MULTISAMPLE_PATTERN                         = 671,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_INVALID_USE_OF_FORCED_SAMPLE_COUNT                                = 672,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_INVALID_PRIMITIVETOPOLOGY                                         = 673,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_INVALID_SYSTEMVALUE                                               = 674,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_OM_DUAL_SOURCE_BLENDING_CAN_ONLY_HAVE_RENDER_TARGET_0             = 675,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_OM_RENDER_TARGET_DOES_NOT_SUPPORT_BLENDING                        = 676,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_PS_OUTPUT_TYPE_MISMATCH                                           = 677,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_OM_RENDER_TARGET_DOES_NOT_SUPPORT_LOGIC_OPS                       = 678,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_RENDERTARGETVIEW_NOT_SET                                          = 679,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_DEPTHSTENCILVIEW_NOT_SET                                          = 680,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_GS_INPUT_PRIMITIVE_MISMATCH                                       = 681,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_POSITION_NOT_PRESENT                                              = 682,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_MISSING_ROOT_SIGNATURE_FLAGS                                      = 683,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_INVALID_INDEX_BUFFER_PROPERTIES                                   = 684,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_INVALID_SAMPLE_DESC                                               = 685,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_HS_ROOT_SIGNATURE_MISMATCH                                        = 686,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_DS_ROOT_SIGNATURE_MISMATCH                                        = 687,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_VS_ROOT_SIGNATURE_MISMATCH                                        = 688,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_GS_ROOT_SIGNATURE_MISMATCH                                        = 689,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_PS_ROOT_SIGNATURE_MISMATCH                                        = 690,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_MISSING_ROOT_SIGNATURE                                            = 691,
    D3D12_MESSAGE_ID_EXECUTE_BUNDLE_OPEN_BUNDLE                                                                    = 692,
    D3D12_MESSAGE_ID_EXECUTE_BUNDLE_DESCRIPTOR_HEAP_MISMATCH                                                       = 693,
    D3D12_MESSAGE_ID_EXECUTE_BUNDLE_TYPE                                                                           = 694,
    D3D12_MESSAGE_ID_DRAW_EMPTY_SCISSOR_RECTANGLE                                                                  = 695,
    D3D12_MESSAGE_ID_CREATE_ROOT_SIGNATURE_BLOB_NOT_FOUND                                                          = 696,
    D3D12_MESSAGE_ID_CREATE_ROOT_SIGNATURE_DESERIALIZE_FAILED                                                      = 697,
    D3D12_MESSAGE_ID_CREATE_ROOT_SIGNATURE_INVALID_CONFIGURATION                                                   = 698,
    D3D12_MESSAGE_ID_CREATE_ROOT_SIGNATURE_NOT_SUPPORTED_ON_DEVICE                                                 = 699,
    D3D12_MESSAGE_ID_CREATERESOURCEANDHEAP_NULLRESOURCEPROPERTIES                                                  = 700,
    D3D12_MESSAGE_ID_CREATERESOURCEANDHEAP_NULLHEAP                                                                = 701,
    D3D12_MESSAGE_ID_GETRESOURCEALLOCATIONINFO_INVALIDRDESCS                                                       = 702,
    D3D12_MESSAGE_ID_MAKERESIDENT_NULLOBJECTARRAY                                                                  = 703,
    D3D12_MESSAGE_ID_EVICT_NULLOBJECTARRAY                                                                         = 705,
    D3D12_MESSAGE_ID_SET_DESCRIPTOR_TABLE_INVALID                                                                  = 708,
    D3D12_MESSAGE_ID_SET_ROOT_CONSTANT_INVALID                                                                     = 709,
    D3D12_MESSAGE_ID_SET_ROOT_CONSTANT_BUFFER_VIEW_INVALID                                                         = 710,
    D3D12_MESSAGE_ID_SET_ROOT_SHADER_RESOURCE_VIEW_INVALID                                                         = 711,
    D3D12_MESSAGE_ID_SET_ROOT_UNORDERED_ACCESS_VIEW_INVALID                                                        = 712,
    D3D12_MESSAGE_ID_SET_VERTEX_BUFFERS_INVALID_DESC                                                               = 713,
    D3D12_MESSAGE_ID_SET_INDEX_BUFFER_INVALID_DESC                                                                 = 715,
    D3D12_MESSAGE_ID_SET_STREAM_OUTPUT_BUFFERS_INVALID_DESC                                                        = 717,
    D3D12_MESSAGE_ID_CREATERESOURCE_UNRECOGNIZEDDIMENSIONALITY                                                     = 718,
    D3D12_MESSAGE_ID_CREATERESOURCE_UNRECOGNIZEDLAYOUT                                                             = 719,
    D3D12_MESSAGE_ID_CREATERESOURCE_INVALIDDIMENSIONALITY                                                          = 720,
    D3D12_MESSAGE_ID_CREATERESOURCE_INVALIDALIGNMENT                                                               = 721,
    D3D12_MESSAGE_ID_CREATERESOURCE_INVALIDMIPLEVELS                                                               = 722,
    D3D12_MESSAGE_ID_CREATERESOURCE_INVALIDSAMPLEDESC                                                              = 723,
    D3D12_MESSAGE_ID_CREATERESOURCE_INVALIDLAYOUT                                                                  = 724,
    D3D12_MESSAGE_ID_SET_INDEX_BUFFER_INVALID                                                                      = 725,
    D3D12_MESSAGE_ID_SET_VERTEX_BUFFERS_INVALID                                                                    = 726,
    D3D12_MESSAGE_ID_SET_STREAM_OUTPUT_BUFFERS_INVALID                                                             = 727,
    D3D12_MESSAGE_ID_SET_RENDER_TARGETS_INVALID                                                                    = 728,
    D3D12_MESSAGE_ID_CREATEQUERY_HEAP_INVALID_PARAMETERS                                                           = 729,
    D3D12_MESSAGE_ID_BEGIN_END_QUERY_INVALID_PARAMETERS                                                            = 731,
    D3D12_MESSAGE_ID_CLOSE_COMMAND_LIST_OPEN_QUERY                                                                 = 732,
    D3D12_MESSAGE_ID_RESOLVE_QUERY_DATA_INVALID_PARAMETERS                                                         = 733,
    D3D12_MESSAGE_ID_SET_PREDICATION_INVALID_PARAMETERS                                                            = 734,
    D3D12_MESSAGE_ID_TIMESTAMPS_NOT_SUPPORTED                                                                      = 735,
    // This was shipped, but is no longer used. Do not reuse.
    //D3D12_MESSAGE_ID_UNSTABLE_POWER_STATE                                                                        = 736,
    D3D12_MESSAGE_ID_CREATERESOURCE_UNRECOGNIZEDFORMAT                                                             = 737,
    D3D12_MESSAGE_ID_CREATERESOURCE_INVALIDFORMAT                                                                  = 738,
    D3D12_MESSAGE_ID_GETCOPYABLEFOOTPRINTS_INVALIDSUBRESOURCERANGE                                                 = 739,
    D3D12_MESSAGE_ID_GETCOPYABLEFOOTPRINTS_INVALIDBASEOFFSET                                                       = 740,
    // Note: These are the same as the above two, with the original (incorrect) name
    D3D12_MESSAGE_ID_GETCOPYABLELAYOUT_INVALIDSUBRESOURCERANGE                                                     = 739,
    D3D12_MESSAGE_ID_GETCOPYABLELAYOUT_INVALIDBASEOFFSET                                                           = 740,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_INVALID_HEAP                                                                 = 741,
    D3D12_MESSAGE_ID_CREATE_SAMPLER_INVALID                                                                        = 742,
    D3D12_MESSAGE_ID_CREATECOMMANDSIGNATURE_INVALID                                                                = 743,
    D3D12_MESSAGE_ID_EXECUTE_INDIRECT_INVALID_PARAMETERS                                                           = 744,
    D3D12_MESSAGE_ID_GETGPUVIRTUALADDRESS_INVALID_RESOURCE_DIMENSION                                               = 745,
    // These values shipped, but are no longer used.  Do not reuse.
    //D3D12_MESSAGE_ID_CREATEQUERYORPREDICATE_INVALIDCONTEXTTYPE                                                   = 746,
    //D3D12_MESSAGE_ID_CREATEQUERYORPREDICATE_DECODENOTSUPPORTED                                                   = 747,
    //D3D12_MESSAGE_ID_CREATEQUERYORPREDICATE_ENCODENOTSUPPORTED                                                   = 748,
    D3D12_MESSAGE_ID_CREATERESOURCE_INVALIDCLEARVALUE                                                              = 815,
    D3D12_MESSAGE_ID_CREATERESOURCE_UNRECOGNIZEDCLEARVALUEFORMAT                                                   = 816,
    D3D12_MESSAGE_ID_CREATERESOURCE_INVALIDCLEARVALUEFORMAT                                                        = 817,
    D3D12_MESSAGE_ID_CREATERESOURCE_CLEARVALUEDENORMFLUSH                                                          = 818,
    D3D12_MESSAGE_ID_CLEARRENDERTARGETVIEW_MISMATCHINGCLEARVALUE                                                   = 820,
    D3D12_MESSAGE_ID_CLEARDEPTHSTENCILVIEW_MISMATCHINGCLEARVALUE                                                   = 821,
    D3D12_MESSAGE_ID_MAP_INVALIDHEAP                                                                               = 822,
    D3D12_MESSAGE_ID_UNMAP_INVALIDHEAP                                                                             = 823,
    D3D12_MESSAGE_ID_MAP_INVALIDRESOURCE                                                                           = 824,
    D3D12_MESSAGE_ID_UNMAP_INVALIDRESOURCE                                                                         = 825,
    D3D12_MESSAGE_ID_MAP_INVALIDSUBRESOURCE                                                                        = 826,
    D3D12_MESSAGE_ID_UNMAP_INVALIDSUBRESOURCE                                                                      = 827,
    D3D12_MESSAGE_ID_MAP_INVALIDRANGE                                                                              = 828,
    D3D12_MESSAGE_ID_UNMAP_INVALIDRANGE                                                                            = 829,
    D3D12_MESSAGE_ID_MAP_INVALIDDATAPOINTER                                                                        = 832,
    D3D12_MESSAGE_ID_MAP_INVALIDARG_RETURN                                                                         = 833,
    D3D12_MESSAGE_ID_MAP_OUTOFMEMORY_RETURN                                                                        = 834,
    D3D12_MESSAGE_ID_EXECUTECOMMANDLISTS_BUNDLENOTSUPPORTED                                                        = 835,
    D3D12_MESSAGE_ID_EXECUTECOMMANDLISTS_COMMANDLISTMISMATCH                                                       = 836,
    D3D12_MESSAGE_ID_EXECUTECOMMANDLISTS_OPENCOMMANDLIST                                                           = 837,
    D3D12_MESSAGE_ID_EXECUTECOMMANDLISTS_FAILEDCOMMANDLIST                                                         = 838,
    D3D12_MESSAGE_ID_COPYBUFFERREGION_NULLDST                                                                      = 839,
    D3D12_MESSAGE_ID_COPYBUFFERREGION_INVALIDDSTRESOURCEDIMENSION                                                  = 840,
    D3D12_MESSAGE_ID_COPYBUFFERREGION_DSTRANGEOUTOFBOUNDS                                                          = 841,
    D3D12_MESSAGE_ID_COPYBUFFERREGION_NULLSRC                                                                      = 842,
    D3D12_MESSAGE_ID_COPYBUFFERREGION_INVALIDSRCRESOURCEDIMENSION                                                  = 843,
    D3D12_MESSAGE_ID_COPYBUFFERREGION_SRCRANGEOUTOFBOUNDS                                                          = 844,
    D3D12_MESSAGE_ID_COPYBUFFERREGION_INVALIDCOPYFLAGS                                                             = 845,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_NULLDST                                                                     = 846,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_UNRECOGNIZEDDSTTYPE                                                         = 847,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDDSTRESOURCEDIMENSION                                                 = 848,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDDSTRESOURCE                                                          = 849,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDDSTSUBRESOURCE                                                       = 850,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDDSTOFFSET                                                            = 851,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_UNRECOGNIZEDDSTFORMAT                                                       = 852,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDDSTFORMAT                                                            = 853,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDDSTDIMENSIONS                                                        = 854,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDDSTROWPITCH                                                          = 855,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDDSTPLACEMENT                                                         = 856,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDDSTDSPLACEDFOOTPRINTFORMAT                                           = 857,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_DSTREGIONOUTOFBOUNDS                                                        = 858,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_NULLSRC                                                                     = 859,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_UNRECOGNIZEDSRCTYPE                                                         = 860,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDSRCRESOURCEDIMENSION                                                 = 861,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDSRCRESOURCE                                                          = 862,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDSRCSUBRESOURCE                                                       = 863,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDSRCOFFSET                                                            = 864,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_UNRECOGNIZEDSRCFORMAT                                                       = 865,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDSRCFORMAT                                                            = 866,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDSRCDIMENSIONS                                                        = 867,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDSRCROWPITCH                                                          = 868,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDSRCPLACEMENT                                                         = 869,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDSRCDSPLACEDFOOTPRINTFORMAT                                           = 870,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_SRCREGIONOUTOFBOUNDS                                                        = 871,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDDSTCOORDINATES                                                       = 872,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDSRCBOX                                                               = 873,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_FORMATMISMATCH                                                              = 874,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_EMPTYBOX                                                                    = 875,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_INVALIDCOPYFLAGS                                                            = 876,
    D3D12_MESSAGE_ID_RESOLVESUBRESOURCE_INVALID_SUBRESOURCE_INDEX                                                  = 877,
    D3D12_MESSAGE_ID_RESOLVESUBRESOURCE_INVALID_FORMAT                                                             = 878,
    D3D12_MESSAGE_ID_RESOLVESUBRESOURCE_RESOURCE_MISMATCH                                                          = 879,
    D3D12_MESSAGE_ID_RESOLVESUBRESOURCE_INVALID_SAMPLE_COUNT                                                       = 880,
    D3D12_MESSAGE_ID_CREATECOMPUTEPIPELINESTATE_INVALID_SHADER                                                     = 881,
    D3D12_MESSAGE_ID_CREATECOMPUTEPIPELINESTATE_CS_ROOT_SIGNATURE_MISMATCH                                         = 882,
    D3D12_MESSAGE_ID_CREATECOMPUTEPIPELINESTATE_MISSING_ROOT_SIGNATURE                                             = 883,
    D3D12_MESSAGE_ID_CREATEPIPELINESTATE_INVALIDCACHEDBLOB                                                         = 884,
    D3D12_MESSAGE_ID_CREATEPIPELINESTATE_CACHEDBLOBADAPTERMISMATCH                                                 = 885,
    D3D12_MESSAGE_ID_CREATEPIPELINESTATE_CACHEDBLOBDRIVERVERSIONMISMATCH                                           = 886,
    D3D12_MESSAGE_ID_CREATEPIPELINESTATE_CACHEDBLOBDESCMISMATCH                                                    = 887,
    D3D12_MESSAGE_ID_CREATEPIPELINESTATE_CACHEDBLOBIGNORED                                                         = 888,
    D3D12_MESSAGE_ID_WRITETOSUBRESOURCE_INVALIDHEAP                                                                = 889,
    D3D12_MESSAGE_ID_WRITETOSUBRESOURCE_INVALIDRESOURCE                                                            = 890,
    D3D12_MESSAGE_ID_WRITETOSUBRESOURCE_INVALIDBOX                                                                 = 891,
    D3D12_MESSAGE_ID_WRITETOSUBRESOURCE_INVALIDSUBRESOURCE                                                         = 892,
    D3D12_MESSAGE_ID_WRITETOSUBRESOURCE_EMPTYBOX                                                                   = 893,
    D3D12_MESSAGE_ID_READFROMSUBRESOURCE_INVALIDHEAP                                                               = 894,
    D3D12_MESSAGE_ID_READFROMSUBRESOURCE_INVALIDRESOURCE                                                           = 895,
    D3D12_MESSAGE_ID_READFROMSUBRESOURCE_INVALIDBOX                                                                = 896,
    D3D12_MESSAGE_ID_READFROMSUBRESOURCE_INVALIDSUBRESOURCE                                                        = 897,
    D3D12_MESSAGE_ID_READFROMSUBRESOURCE_EMPTYBOX                                                                  = 898,
    D3D12_MESSAGE_ID_TOO_MANY_NODES_SPECIFIED                                                                      = 899,
    D3D12_MESSAGE_ID_INVALID_NODE_INDEX                                                                            = 900,
    D3D12_MESSAGE_ID_GETHEAPPROPERTIES_INVALIDRESOURCE                                                             = 901,
    D3D12_MESSAGE_ID_NODE_MASK_MISMATCH                                                                            = 902,
    D3D12_MESSAGE_ID_COMMAND_LIST_OUTOFMEMORY                                                                      = 903,
    D3D12_MESSAGE_ID_COMMAND_LIST_MULTIPLE_SWAPCHAIN_BUFFER_REFERENCES                                             = 904,
    D3D12_MESSAGE_ID_COMMAND_LIST_TOO_MANY_SWAPCHAIN_REFERENCES                                                    = 905,
    D3D12_MESSAGE_ID_COMMAND_QUEUE_TOO_MANY_SWAPCHAIN_REFERENCES                                                   = 906,
    D3D12_MESSAGE_ID_EXECUTECOMMANDLISTS_WRONGSWAPCHAINBUFFERREFERENCE                                             = 907,
    D3D12_MESSAGE_ID_COMMAND_LIST_SETRENDERTARGETS_INVALIDNUMRENDERTARGETS                                         = 908,
    D3D12_MESSAGE_ID_CREATE_QUEUE_INVALID_TYPE                                                                     = 909,
    D3D12_MESSAGE_ID_CREATE_QUEUE_INVALID_FLAGS                                                                    = 910,
    D3D12_MESSAGE_ID_CREATESHAREDRESOURCE_INVALIDFLAGS                                                             = 911,
    D3D12_MESSAGE_ID_CREATESHAREDRESOURCE_INVALIDFORMAT                                                            = 912,
    D3D12_MESSAGE_ID_CREATESHAREDHEAP_INVALIDFLAGS                                                                 = 913,
    D3D12_MESSAGE_ID_REFLECTSHAREDPROPERTIES_UNRECOGNIZEDPROPERTIES                                                = 914,
    D3D12_MESSAGE_ID_REFLECTSHAREDPROPERTIES_INVALIDSIZE                                                           = 915,
    D3D12_MESSAGE_ID_REFLECTSHAREDPROPERTIES_INVALIDOBJECT                                                         = 916,
    D3D12_MESSAGE_ID_KEYEDMUTEX_INVALIDOBJECT                                                                      = 917,
    D3D12_MESSAGE_ID_KEYEDMUTEX_INVALIDKEY                                                                         = 918,
    D3D12_MESSAGE_ID_KEYEDMUTEX_WRONGSTATE                                                                         = 919,
    D3D12_MESSAGE_ID_CREATE_QUEUE_INVALID_PRIORITY                                                                 = 920,
    D3D12_MESSAGE_ID_OBJECT_DELETED_WHILE_STILL_IN_USE                                                             = 921,
    D3D12_MESSAGE_ID_CREATEPIPELINESTATE_INVALID_FLAGS                                                             = 922,
    D3D12_MESSAGE_ID_HEAP_ADDRESS_RANGE_HAS_NO_RESOURCE                                                            = 923,
    D3D12_MESSAGE_ID_COMMAND_LIST_DRAW_RENDER_TARGET_DELETED                                                       = 924,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_ALL_RENDER_TARGETS_HAVE_UNKNOWN_FORMAT                            = 925,
    D3D12_MESSAGE_ID_HEAP_ADDRESS_RANGE_INTERSECTS_MULTIPLE_BUFFERS                                                = 926,
    D3D12_MESSAGE_ID_EXECUTECOMMANDLISTS_GPU_WRITTEN_READBACK_RESOURCE_MAPPED                                      = 927,
    D3D12_MESSAGE_ID_UNMAP_RANGE_NOT_EMPTY                                                                         = 929,
    D3D12_MESSAGE_ID_MAP_INVALID_NULLRANGE                                                                         = 930,
    D3D12_MESSAGE_ID_UNMAP_INVALID_NULLRANGE                                                                       = 931,
    D3D12_MESSAGE_ID_NO_GRAPHICS_API_SUPPORT                                                                       = 932,
    D3D12_MESSAGE_ID_NO_COMPUTE_API_SUPPORT                                                                        = 933,
    D3D12_MESSAGE_ID_RESOLVESUBRESOURCE_RESOURCE_FLAGS_NOT_SUPPORTED                                               = 934,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_ROOT_ARGUMENT_UNINITIALIZED                                              = 935,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_DESCRIPTOR_HEAP_INDEX_OUT_OF_BOUNDS                                      = 936,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_DESCRIPTOR_TABLE_REGISTER_INDEX_OUT_OF_BOUNDS                            = 937,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_DESCRIPTOR_UNINITIALIZED                                                 = 938,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_DESCRIPTOR_TYPE_MISMATCH                                                 = 939,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_SRV_RESOURCE_DIMENSION_MISMATCH                                          = 940,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_UAV_RESOURCE_DIMENSION_MISMATCH                                          = 941,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_INCOMPATIBLE_RESOURCE_STATE                                              = 942,
    D3D12_MESSAGE_ID_COPYRESOURCE_NULLDST                                                                          = 943,
    D3D12_MESSAGE_ID_COPYRESOURCE_INVALIDDSTRESOURCE                                                               = 944,
    D3D12_MESSAGE_ID_COPYRESOURCE_NULLSRC                                                                          = 945,
    D3D12_MESSAGE_ID_COPYRESOURCE_INVALIDSRCRESOURCE                                                               = 946,
    D3D12_MESSAGE_ID_RESOLVESUBRESOURCE_NULLDST                                                                    = 947,
    D3D12_MESSAGE_ID_RESOLVESUBRESOURCE_INVALIDDSTRESOURCE                                                         = 948,
    D3D12_MESSAGE_ID_RESOLVESUBRESOURCE_NULLSRC                                                                    = 949,
    D3D12_MESSAGE_ID_RESOLVESUBRESOURCE_INVALIDSRCRESOURCE                                                         = 950,
    D3D12_MESSAGE_ID_PIPELINE_STATE_TYPE_MISMATCH                                                                  = 951,
    D3D12_MESSAGE_ID_COMMAND_LIST_DISPATCH_ROOT_SIGNATURE_NOT_SET                                                  = 952,
    D3D12_MESSAGE_ID_COMMAND_LIST_DISPATCH_ROOT_SIGNATURE_MISMATCH                                                 = 953,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_ZERO_BARRIERS                                                                = 954,
    D3D12_MESSAGE_ID_BEGIN_END_EVENT_MISMATCH                                                                      = 955,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_POSSIBLE_BEFORE_AFTER_MISMATCH                                               = 956,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_MISMATCHING_BEGIN_END                                                        = 957,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_INVALID_RESOURCE                                                         = 958,
    D3D12_MESSAGE_ID_USE_OF_ZERO_REFCOUNT_OBJECT                                                                   = 959,
    D3D12_MESSAGE_ID_OBJECT_EVICTED_WHILE_STILL_IN_USE                                                             = 960,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_ROOT_DESCRIPTOR_ACCESS_OUT_OF_BOUNDS                                     = 961,
    D3D12_MESSAGE_ID_CREATEPIPELINELIBRARY_INVALIDLIBRARYBLOB                                                      = 962,
    D3D12_MESSAGE_ID_CREATEPIPELINELIBRARY_DRIVERVERSIONMISMATCH                                                   = 963,
    D3D12_MESSAGE_ID_CREATEPIPELINELIBRARY_ADAPTERVERSIONMISMATCH                                                  = 964,
    D3D12_MESSAGE_ID_CREATEPIPELINELIBRARY_UNSUPPORTED                                                             = 965,
    D3D12_MESSAGE_ID_CREATE_PIPELINELIBRARY                                                                        = 966,
    D3D12_MESSAGE_ID_LIVE_PIPELINELIBRARY                                                                          = 967,
    D3D12_MESSAGE_ID_DESTROY_PIPELINELIBRARY                                                                       = 968,
    D3D12_MESSAGE_ID_STOREPIPELINE_NONAME                                                                          = 969,
    D3D12_MESSAGE_ID_STOREPIPELINE_DUPLICATENAME                                                                   = 970,
    D3D12_MESSAGE_ID_LOADPIPELINE_NAMENOTFOUND                                                                     = 971,
    D3D12_MESSAGE_ID_LOADPIPELINE_INVALIDDESC                                                                      = 972,
    D3D12_MESSAGE_ID_PIPELINELIBRARY_SERIALIZE_NOTENOUGHMEMORY                                                     = 973,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_PS_OUTPUT_RT_OUTPUT_MISMATCH                                      = 974,
    D3D12_MESSAGE_ID_SETEVENTONMULTIPLEFENCECOMPLETION_INVALIDFLAGS                                                = 975,
    D3D12_MESSAGE_ID_CREATE_QUEUE_VIDEO_NOT_SUPPORTED                                                              = 976,
    D3D12_MESSAGE_ID_CREATE_COMMAND_ALLOCATOR_VIDEO_NOT_SUPPORTED                                                  = 977,
    D3D12_MESSAGE_ID_CREATEQUERY_HEAP_VIDEO_DECODE_STATISTICS_NOT_SUPPORTED                                        = 978,
    D3D12_MESSAGE_ID_CREATE_VIDEODECODECOMMANDLIST                                                                 = 979,
    D3D12_MESSAGE_ID_CREATE_VIDEODECODER                                                                           = 980,
    D3D12_MESSAGE_ID_CREATE_VIDEODECODESTREAM                                                                      = 981,
    D3D12_MESSAGE_ID_LIVE_VIDEODECODECOMMANDLIST                                                                   = 982,
    D3D12_MESSAGE_ID_LIVE_VIDEODECODER                                                                             = 983,
    D3D12_MESSAGE_ID_LIVE_VIDEODECODESTREAM                                                                        = 984,
    D3D12_MESSAGE_ID_DESTROY_VIDEODECODECOMMANDLIST                                                                = 985,
    D3D12_MESSAGE_ID_DESTROY_VIDEODECODER                                                                          = 986,
    D3D12_MESSAGE_ID_DESTROY_VIDEODECODESTREAM                                                                     = 987,
    D3D12_MESSAGE_ID_DECODE_FRAME_INVALID_PARAMETERS                                                               = 988,
    D3D12_MESSAGE_ID_DEPRECATED_API                                                                                = 989,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_MISMATCHING_COMMAND_LIST_TYPE                                                = 990,
    D3D12_MESSAGE_ID_COMMAND_LIST_DESCRIPTOR_TABLE_NOT_SET                                                         = 991,
    D3D12_MESSAGE_ID_COMMAND_LIST_ROOT_CONSTANT_BUFFER_VIEW_NOT_SET                                                = 992,
    D3D12_MESSAGE_ID_COMMAND_LIST_ROOT_SHADER_RESOURCE_VIEW_NOT_SET                                                = 993,
    D3D12_MESSAGE_ID_COMMAND_LIST_ROOT_UNORDERED_ACCESS_VIEW_NOT_SET                                               = 994,
    D3D12_MESSAGE_ID_DISCARD_INVALID_SUBRESOURCE_RANGE                                                             = 995,
    D3D12_MESSAGE_ID_DISCARD_ONE_SUBRESOURCE_FOR_MIPS_WITH_RECTS                                                   = 996,
    D3D12_MESSAGE_ID_DISCARD_NO_RECTS_FOR_NON_TEXTURE2D                                                            = 997,
    D3D12_MESSAGE_ID_COPY_ON_SAME_SUBRESOURCE                                                                      = 998,
    D3D12_MESSAGE_ID_SETRESIDENCYPRIORITY_INVALID_PAGEABLE                                                         = 999,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_UNSUPPORTED                                                              = 1000,
    D3D12_MESSAGE_ID_STATIC_DESCRIPTOR_INVALID_DESCRIPTOR_CHANGE                                                   = 1001,
    D3D12_MESSAGE_ID_DATA_STATIC_DESCRIPTOR_INVALID_DATA_CHANGE                                                    = 1002,
    D3D12_MESSAGE_ID_DATA_STATIC_WHILE_SET_AT_EXECUTE_DESCRIPTOR_INVALID_DATA_CHANGE                               = 1003,
    D3D12_MESSAGE_ID_EXECUTE_BUNDLE_STATIC_DESCRIPTOR_DATA_STATIC_NOT_SET                                          = 1004,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_RESOURCE_ACCESS_OUT_OF_BOUNDS                                            = 1005,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_SAMPLER_MODE_MISMATCH                                                    = 1006,
    D3D12_MESSAGE_ID_CREATE_FENCE_INVALID_FLAGS                                                                    = 1007,
    D3D12_MESSAGE_ID_RESOURCE_BARRIER_DUPLICATE_SUBRESOURCE_TRANSITIONS                                            = 1008,
    D3D12_MESSAGE_ID_SETRESIDENCYPRIORITY_INVALID_PRIORITY                                                         = 1009,
    D3D12_MESSAGE_ID_CREATE_DESCRIPTOR_HEAP_LARGE_NUM_DESCRIPTORS                                                  = 1013,
    D3D12_MESSAGE_ID_BEGIN_EVENT                                                                                   = 1014,
    D3D12_MESSAGE_ID_END_EVENT                                                                                     = 1015,
    D3D12_MESSAGE_ID_CREATEDEVICE_DEBUG_LAYER_STARTUP_OPTIONS                                                      = 1016,
    D3D12_MESSAGE_ID_CREATEDEPTHSTENCILSTATE_DEPTHBOUNDSTEST_UNSUPPORTED                                           = 1017,
    D3D12_MESSAGE_ID_CREATEPIPELINESTATE_DUPLICATE_SUBOBJECT                                                       = 1018,
    D3D12_MESSAGE_ID_CREATEPIPELINESTATE_UNKNOWN_SUBOBJECT                                                         = 1019,
    D3D12_MESSAGE_ID_CREATEPIPELINESTATE_ZERO_SIZE_STREAM                                                          = 1020,
    D3D12_MESSAGE_ID_CREATEPIPELINESTATE_INVALID_STREAM                                                            = 1021,
    D3D12_MESSAGE_ID_CREATEPIPELINESTATE_CANNOT_DEDUCE_TYPE                                                        = 1022,
    D3D12_MESSAGE_ID_COMMAND_LIST_STATIC_DESCRIPTOR_RESOURCE_DIMENSION_MISMATCH                                    = 1023,
    D3D12_MESSAGE_ID_CREATE_COMMAND_QUEUE_INSUFFICIENT_PRIVILEGE_FOR_GLOBAL_REALTIME                               = 1024,
    D3D12_MESSAGE_ID_CREATE_COMMAND_QUEUE_INSUFFICIENT_HARDWARE_SUPPORT_FOR_GLOBAL_REALTIME                        = 1025,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_INVALID_ARCHITECTURE                                                         = 1026,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_NULL_DST                                                                     = 1027,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_INVALID_DST_RESOURCE_DIMENSION                                               = 1028,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_DST_RANGE_OUT_OF_BOUNDS                                                      = 1029,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_NULL_SRC                                                                     = 1030,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_INVALID_SRC_RESOURCE_DIMENSION                                               = 1031,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_SRC_RANGE_OUT_OF_BOUNDS                                                      = 1032,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_INVALID_OFFSET_ALIGNMENT                                                     = 1033,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_NULL_DEPENDENT_RESOURCES                                                     = 1034,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_NULL_DEPENDENT_SUBRESOURCE_RANGES                                            = 1035,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_INVALID_DEPENDENT_RESOURCE                                                   = 1036,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_INVALID_DEPENDENT_SUBRESOURCE_RANGE                                          = 1037,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_DEPENDENT_SUBRESOURCE_OUT_OF_BOUNDS                                          = 1038,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_DEPENDENT_RANGE_OUT_OF_BOUNDS                                                = 1039,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_ZERO_DEPENDENCIES                                                            = 1040,
    D3D12_MESSAGE_ID_DEVICE_CREATE_SHARED_HANDLE_INVALIDARG                                                        = 1041,
    D3D12_MESSAGE_ID_DESCRIPTOR_HANDLE_WITH_INVALID_RESOURCE                                                       = 1042,
    D3D12_MESSAGE_ID_SETDEPTHBOUNDS_INVALIDARGS                                                                    = 1043,
    D3D12_MESSAGE_ID_GPU_BASED_VALIDATION_RESOURCE_STATE_IMPRECISE                                                 = 1044,
    D3D12_MESSAGE_ID_COMMAND_LIST_PIPELINE_STATE_NOT_SET                                                           = 1045,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_SHADER_MODEL_MISMATCH                                             = 1046,
    D3D12_MESSAGE_ID_OBJECT_ACCESSED_WHILE_STILL_IN_USE                                                            = 1047,
    D3D12_MESSAGE_ID_PROGRAMMABLE_MSAA_UNSUPPORTED                                                                 = 1048,
    D3D12_MESSAGE_ID_SETSAMPLEPOSITIONS_INVALIDARGS                                                                = 1049,
    D3D12_MESSAGE_ID_RESOLVESUBRESOURCEREGION_INVALID_RECT                                                         = 1050,
    D3D12_MESSAGE_ID_CREATE_VIDEODECODECOMMANDQUEUE                                                                = 1051,
    D3D12_MESSAGE_ID_CREATE_VIDEOPROCESSCOMMANDLIST                                                                = 1052,
    D3D12_MESSAGE_ID_CREATE_VIDEOPROCESSCOMMANDQUEUE                                                               = 1053,
    D3D12_MESSAGE_ID_LIVE_VIDEODECODECOMMANDQUEUE                                                                  = 1054,
    D3D12_MESSAGE_ID_LIVE_VIDEOPROCESSCOMMANDLIST                                                                  = 1055,
    D3D12_MESSAGE_ID_LIVE_VIDEOPROCESSCOMMANDQUEUE                                                                 = 1056,
    D3D12_MESSAGE_ID_DESTROY_VIDEODECODECOMMANDQUEUE                                                               = 1057,
    D3D12_MESSAGE_ID_DESTROY_VIDEOPROCESSCOMMANDLIST                                                               = 1058,
    D3D12_MESSAGE_ID_DESTROY_VIDEOPROCESSCOMMANDQUEUE                                                              = 1059,
    D3D12_MESSAGE_ID_CREATE_VIDEOPROCESSOR                                                                         = 1060,
    D3D12_MESSAGE_ID_CREATE_VIDEOPROCESSSTREAM                                                                     = 1061,
    D3D12_MESSAGE_ID_LIVE_VIDEOPROCESSOR                                                                           = 1062,
    D3D12_MESSAGE_ID_LIVE_VIDEOPROCESSSTREAM                                                                       = 1063,
    D3D12_MESSAGE_ID_DESTROY_VIDEOPROCESSOR                                                                        = 1064,
    D3D12_MESSAGE_ID_DESTROY_VIDEOPROCESSSTREAM                                                                    = 1065,
    D3D12_MESSAGE_ID_PROCESS_FRAME_INVALID_PARAMETERS                                                              = 1066,
    D3D12_MESSAGE_ID_COPY_INVALIDLAYOUT                                                                            = 1067,
    D3D12_MESSAGE_ID_CREATE_CRYPTO_SESSION                                                                         = 1068,
    D3D12_MESSAGE_ID_CREATE_CRYPTO_SESSION_POLICY                                                                  = 1069,
    D3D12_MESSAGE_ID_CREATE_PROTECTED_RESOURCE_SESSION                                                             = 1070,
    D3D12_MESSAGE_ID_LIVE_CRYPTO_SESSION                                                                           = 1071,
    D3D12_MESSAGE_ID_LIVE_CRYPTO_SESSION_POLICY                                                                    = 1072,
    D3D12_MESSAGE_ID_LIVE_PROTECTED_RESOURCE_SESSION                                                               = 1073,
    D3D12_MESSAGE_ID_DESTROY_CRYPTO_SESSION                                                                        = 1074,
    D3D12_MESSAGE_ID_DESTROY_CRYPTO_SESSION_POLICY                                                                 = 1075,
    D3D12_MESSAGE_ID_DESTROY_PROTECTED_RESOURCE_SESSION                                                            = 1076,
    D3D12_MESSAGE_ID_PROTECTED_RESOURCE_SESSION_UNSUPPORTED                                                        = 1077,
    D3D12_MESSAGE_ID_FENCE_INVALIDOPERATION                                                                        = 1078,
    D3D12_MESSAGE_ID_CREATEQUERY_HEAP_COPY_QUEUE_TIMESTAMPS_NOT_SUPPORTED                                          = 1079,
    D3D12_MESSAGE_ID_SAMPLEPOSITIONS_MISMATCH_DEFERRED                                                             = 1080,
    D3D12_MESSAGE_ID_SAMPLEPOSITIONS_MISMATCH_RECORDTIME_ASSUMEDFROMFIRSTUSE                                       = 1081,
    D3D12_MESSAGE_ID_SAMPLEPOSITIONS_MISMATCH_RECORDTIME_ASSUMEDFROMCLEAR                                          = 1082,
    D3D12_MESSAGE_ID_CREATE_VIDEODECODERHEAP                                                                       = 1083,
    D3D12_MESSAGE_ID_LIVE_VIDEODECODERHEAP                                                                         = 1084,
    D3D12_MESSAGE_ID_DESTROY_VIDEODECODERHEAP                                                                      = 1085,
    D3D12_MESSAGE_ID_OPENEXISTINGHEAP_INVALIDARG_RETURN                                                            = 1086,
    D3D12_MESSAGE_ID_OPENEXISTINGHEAP_OUTOFMEMORY_RETURN                                                           = 1087,
    D3D12_MESSAGE_ID_OPENEXISTINGHEAP_INVALIDADDRESS                                                               = 1088,
    D3D12_MESSAGE_ID_OPENEXISTINGHEAP_INVALIDHANDLE                                                                = 1089,
    D3D12_MESSAGE_ID_WRITEBUFFERIMMEDIATE_INVALID_DEST                                                             = 1090,
    D3D12_MESSAGE_ID_WRITEBUFFERIMMEDIATE_INVALID_MODE                                                             = 1091,
    D3D12_MESSAGE_ID_WRITEBUFFERIMMEDIATE_INVALID_ALIGNMENT                                                        = 1092,
    D3D12_MESSAGE_ID_WRITEBUFFERIMMEDIATE_NOT_SUPPORTED                                                            = 1093,
    D3D12_MESSAGE_ID_SETVIEWINSTANCEMASK_INVALIDARGS                                                               = 1094,
    D3D12_MESSAGE_ID_VIEW_INSTANCING_UNSUPPORTED                                                                   = 1095,
    D3D12_MESSAGE_ID_VIEW_INSTANCING_INVALIDARGS                                                                   = 1096,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_MISMATCH_DECODE_REFERENCE_ONLY_FLAG                                         = 1097,
    D3D12_MESSAGE_ID_COPYRESOURCE_MISMATCH_DECODE_REFERENCE_ONLY_FLAG                                              = 1098,
    D3D12_MESSAGE_ID_CREATE_VIDEO_DECODE_HEAP_CAPS_FAILURE                                                         = 1099,
    D3D12_MESSAGE_ID_CREATE_VIDEO_DECODE_HEAP_CAPS_UNSUPPORTED                                                     = 1100,
    D3D12_MESSAGE_ID_VIDEO_DECODE_SUPPORT_INVALID_INPUT                                                            = 1101,
    D3D12_MESSAGE_ID_CREATE_VIDEO_DECODER_UNSUPPORTED                                                              = 1102,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_METADATA_ERROR                                                    = 1103,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_VIEW_INSTANCING_VERTEX_SIZE_EXCEEDED                              = 1104,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_RUNTIME_INTERNAL_ERROR                                            = 1105,
    D3D12_MESSAGE_ID_NO_VIDEO_API_SUPPORT                                                                          = 1106,
    D3D12_MESSAGE_ID_VIDEO_PROCESS_SUPPORT_INVALID_INPUT                                                           = 1107,
    D3D12_MESSAGE_ID_CREATE_VIDEO_PROCESSOR_CAPS_FAILURE                                                           = 1108,
    D3D12_MESSAGE_ID_VIDEO_PROCESS_SUPPORT_UNSUPPORTED_FORMAT                                                      = 1109,
    D3D12_MESSAGE_ID_VIDEO_DECODE_FRAME_INVALID_ARGUMENT                                                           = 1110,
    D3D12_MESSAGE_ID_ENQUEUE_MAKE_RESIDENT_INVALID_FLAGS                                                           = 1111,
    D3D12_MESSAGE_ID_OPENEXISTINGHEAP_UNSUPPORTED                                                                  = 1112,
    D3D12_MESSAGE_ID_VIDEO_PROCESS_FRAMES_INVALID_ARGUMENT                                                         = 1113,
    D3D12_MESSAGE_ID_VIDEO_DECODE_SUPPORT_UNSUPPORTED                                                              = 1114,
    D3D12_MESSAGE_ID_CREATE_COMMANDRECORDER                                                                        = 1115,
    D3D12_MESSAGE_ID_LIVE_COMMANDRECORDER                                                                          = 1116,
    D3D12_MESSAGE_ID_DESTROY_COMMANDRECORDER                                                                       = 1117,
    D3D12_MESSAGE_ID_CREATE_COMMAND_RECORDER_VIDEO_NOT_SUPPORTED                                                   = 1118,
    D3D12_MESSAGE_ID_CREATE_COMMAND_RECORDER_INVALID_SUPPORT_FLAGS                                                 = 1119,
    D3D12_MESSAGE_ID_CREATE_COMMAND_RECORDER_INVALID_FLAGS                                                         = 1120,
    D3D12_MESSAGE_ID_CREATE_COMMAND_RECORDER_MORE_RECORDERS_THAN_LOGICAL_PROCESSORS                                = 1121,
    D3D12_MESSAGE_ID_CREATE_COMMANDPOOL                                                                            = 1122,
    D3D12_MESSAGE_ID_LIVE_COMMANDPOOL                                                                              = 1123,
    D3D12_MESSAGE_ID_DESTROY_COMMANDPOOL                                                                           = 1124,
    D3D12_MESSAGE_ID_CREATE_COMMAND_POOL_INVALID_FLAGS                                                             = 1125,
    D3D12_MESSAGE_ID_CREATE_COMMAND_LIST_VIDEO_NOT_SUPPORTED                                                       = 1126,
    D3D12_MESSAGE_ID_COMMAND_RECORDER_SUPPORT_FLAGS_MISMATCH                                                       = 1127,
    D3D12_MESSAGE_ID_COMMAND_RECORDER_CONTENTION                                                                   = 1128,
    D3D12_MESSAGE_ID_COMMAND_RECORDER_USAGE_WITH_CREATECOMMANDLIST_COMMAND_LIST                                    = 1129,
    D3D12_MESSAGE_ID_COMMAND_ALLOCATOR_USAGE_WITH_CREATECOMMANDLIST1_COMMAND_LIST                                  = 1130,
    D3D12_MESSAGE_ID_CANNOT_EXECUTE_EMPTY_COMMAND_LIST                                                             = 1131,
    D3D12_MESSAGE_ID_CANNOT_RESET_COMMAND_POOL_WITH_OPEN_COMMAND_LISTS                                             = 1132,
    D3D12_MESSAGE_ID_CANNOT_USE_COMMAND_RECORDER_WITHOUT_CURRENT_TARGET                                            = 1133,
    D3D12_MESSAGE_ID_CANNOT_CHANGE_COMMAND_RECORDER_TARGET_WHILE_RECORDING                                         = 1134,
    D3D12_MESSAGE_ID_COMMAND_POOL_SYNC                                                                             = 1135,
    D3D12_MESSAGE_ID_EVICT_UNDERFLOW                                                                               = 1136,
    D3D12_MESSAGE_ID_CREATE_META_COMMAND                                                                           = 1137,
    D3D12_MESSAGE_ID_LIVE_META_COMMAND                                                                             = 1138,
    D3D12_MESSAGE_ID_DESTROY_META_COMMAND                                                                          = 1139,
    D3D12_MESSAGE_ID_COPYBUFFERREGION_INVALID_DST_RESOURCE                                                         = 1140,
    D3D12_MESSAGE_ID_COPYBUFFERREGION_INVALID_SRC_RESOURCE                                                         = 1141,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_INVALID_DST_RESOURCE                                                         = 1142,
    D3D12_MESSAGE_ID_ATOMICCOPYBUFFER_INVALID_SRC_RESOURCE                                                         = 1143,
    D3D12_MESSAGE_ID_CREATEPLACEDRESOURCEONBUFFER_NULL_BUFFER                                                      = 1144,
    D3D12_MESSAGE_ID_CREATEPLACEDRESOURCEONBUFFER_NULL_RESOURCE_DESC                                               = 1145,
    D3D12_MESSAGE_ID_CREATEPLACEDRESOURCEONBUFFER_UNSUPPORTED                                                      = 1146,
    D3D12_MESSAGE_ID_CREATEPLACEDRESOURCEONBUFFER_INVALID_BUFFER_DIMENSION                                         = 1147,
    D3D12_MESSAGE_ID_CREATEPLACEDRESOURCEONBUFFER_INVALID_BUFFER_FLAGS                                             = 1148,
    D3D12_MESSAGE_ID_CREATEPLACEDRESOURCEONBUFFER_INVALID_BUFFER_OFFSET                                            = 1149,
    D3D12_MESSAGE_ID_CREATEPLACEDRESOURCEONBUFFER_INVALID_RESOURCE_DIMENSION                                       = 1150,
    D3D12_MESSAGE_ID_CREATEPLACEDRESOURCEONBUFFER_INVALID_RESOURCE_FLAGS                                           = 1151,
    D3D12_MESSAGE_ID_CREATEPLACEDRESOURCEONBUFFER_OUTOFMEMORY_RETURN                                               = 1152,
    D3D12_MESSAGE_ID_CANNOT_CREATE_GRAPHICS_AND_VIDEO_COMMAND_RECORDER                                             = 1153,
    D3D12_MESSAGE_ID_UPDATETILEMAPPINGS_POSSIBLY_MISMATCHING_PROPERTIES                                            = 1154,
    D3D12_MESSAGE_ID_CREATE_COMMAND_LIST_INVALID_COMMAND_LIST_TYPE                                                 = 1155,
    D3D12_MESSAGE_ID_CLEARUNORDEREDACCESSVIEW_INCOMPATIBLE_WITH_STRUCTURED_BUFFERS                                 = 1156,
    D3D12_MESSAGE_ID_COMPUTE_ONLY_DEVICE_OPERATION_UNSUPPORTED                                                     = 1157,
    D3D12_MESSAGE_ID_BUILD_RAYTRACING_ACCELERATION_STRUCTURE_INVALID                                               = 1158,
    D3D12_MESSAGE_ID_EMIT_RAYTRACING_ACCELERATION_STRUCTURE_POSTBUILD_INFO_INVALID                                 = 1159,
    D3D12_MESSAGE_ID_COPY_RAYTRACING_ACCELERATION_STRUCTURE_INVALID                                                = 1160,
    D3D12_MESSAGE_ID_DISPATCH_RAYS_INVALID                                                                         = 1161,
    D3D12_MESSAGE_ID_GET_RAYTRACING_ACCELERATION_STRUCTURE_PREBUILD_INFO_INVALID                                   = 1162,
    D3D12_MESSAGE_ID_CREATE_LIFETIMETRACKER                                                                        = 1163,
    D3D12_MESSAGE_ID_LIVE_LIFETIMETRACKER                                                                          = 1164,
    D3D12_MESSAGE_ID_DESTROY_LIFETIMETRACKER                                                                       = 1165,
    D3D12_MESSAGE_ID_DESTROYOWNEDOBJECT_OBJECTNOTOWNED                                                             = 1166,
    D3D12_MESSAGE_ID_CREATE_TRACKEDWORKLOAD                                                                        = 1167,
    D3D12_MESSAGE_ID_LIVE_TRACKEDWORKLOAD                                                                          = 1168,
    D3D12_MESSAGE_ID_DESTROY_TRACKEDWORKLOAD                                                                       = 1169,
    D3D12_MESSAGE_ID_RENDER_PASS_ERROR                                                                             = 1170,
    D3D12_MESSAGE_ID_META_COMMAND_ID_INVALID                                                                       = 1171,
    D3D12_MESSAGE_ID_META_COMMAND_UNSUPPORTED_PARAMS                                                               = 1172,
    D3D12_MESSAGE_ID_META_COMMAND_FAILED_ENUMERATION                                                               = 1173,
    D3D12_MESSAGE_ID_META_COMMAND_PARAMETER_SIZE_MISMATCH                                                          = 1174,
    D3D12_MESSAGE_ID_UNINITIALIZED_META_COMMAND                                                                    = 1175,
    D3D12_MESSAGE_ID_META_COMMAND_INVALID_GPU_VIRTUAL_ADDRESS                                                      = 1176,
    D3D12_MESSAGE_ID_CREATE_VIDEOENCODECOMMANDLIST                                                                 = 1177,
    D3D12_MESSAGE_ID_LIVE_VIDEOENCODECOMMANDLIST                                                                   = 1178,
    D3D12_MESSAGE_ID_DESTROY_VIDEOENCODECOMMANDLIST                                                                = 1179,
    D3D12_MESSAGE_ID_CREATE_VIDEOENCODECOMMANDQUEUE                                                                = 1180,
    D3D12_MESSAGE_ID_LIVE_VIDEOENCODECOMMANDQUEUE                                                                  = 1181,
    D3D12_MESSAGE_ID_DESTROY_VIDEOENCODECOMMANDQUEUE                                                               = 1182,
    D3D12_MESSAGE_ID_CREATE_VIDEOMOTIONESTIMATOR                                                                   = 1183,
    D3D12_MESSAGE_ID_LIVE_VIDEOMOTIONESTIMATOR                                                                     = 1184,
    D3D12_MESSAGE_ID_DESTROY_VIDEOMOTIONESTIMATOR                                                                  = 1185,
    D3D12_MESSAGE_ID_CREATE_VIDEOMOTIONVECTORHEAP                                                                  = 1186,
    D3D12_MESSAGE_ID_LIVE_VIDEOMOTIONVECTORHEAP                                                                    = 1187,
    D3D12_MESSAGE_ID_DESTROY_VIDEOMOTIONVECTORHEAP                                                                 = 1188,
    D3D12_MESSAGE_ID_MULTIPLE_TRACKED_WORKLOADS                                                                    = 1189,
    D3D12_MESSAGE_ID_MULTIPLE_TRACKED_WORKLOAD_PAIRS                                                               = 1190,
    D3D12_MESSAGE_ID_OUT_OF_ORDER_TRACKED_WORKLOAD_PAIR                                                            = 1191,
    D3D12_MESSAGE_ID_CANNOT_ADD_TRACKED_WORKLOAD                                                                   = 1192,
    D3D12_MESSAGE_ID_INCOMPLETE_TRACKED_WORKLOAD_PAIR                                                              = 1193,
    D3D12_MESSAGE_ID_CREATE_STATE_OBJECT_ERROR                                                                     = 1194,
    D3D12_MESSAGE_ID_GET_SHADER_IDENTIFIER_ERROR                                                                   = 1195,
    D3D12_MESSAGE_ID_GET_SHADER_STACK_SIZE_ERROR                                                                   = 1196,
    D3D12_MESSAGE_ID_GET_PIPELINE_STACK_SIZE_ERROR                                                                 = 1197,
    D3D12_MESSAGE_ID_SET_PIPELINE_STACK_SIZE_ERROR                                                                 = 1198,
    D3D12_MESSAGE_ID_GET_SHADER_IDENTIFIER_SIZE_INVALID                                                            = 1199,
    D3D12_MESSAGE_ID_CHECK_DRIVER_MATCHING_IDENTIFIER_INVALID                                                      = 1200,
    D3D12_MESSAGE_ID_CHECK_DRIVER_MATCHING_IDENTIFIER_DRIVER_REPORTED_ISSUE                                        = 1201,
    D3D12_MESSAGE_ID_RENDER_PASS_INVALID_RESOURCE_BARRIER                                                          = 1202,
    D3D12_MESSAGE_ID_RENDER_PASS_DISALLOWED_API_CALLED                                                             = 1203,
    D3D12_MESSAGE_ID_RENDER_PASS_CANNOT_NEST_RENDER_PASSES                                                         = 1204,
    D3D12_MESSAGE_ID_RENDER_PASS_CANNOT_END_WITHOUT_BEGIN                                                          = 1205,
    D3D12_MESSAGE_ID_RENDER_PASS_CANNOT_CLOSE_COMMAND_LIST                                                         = 1206,
    D3D12_MESSAGE_ID_RENDER_PASS_GPU_WORK_WHILE_SUSPENDED                                                          = 1207,
    D3D12_MESSAGE_ID_RENDER_PASS_MISMATCHING_SUSPEND_RESUME                                                        = 1208,
    D3D12_MESSAGE_ID_RENDER_PASS_NO_PRIOR_SUSPEND_WITHIN_EXECUTECOMMANDLISTS                                       = 1209,
    D3D12_MESSAGE_ID_RENDER_PASS_NO_SUBSEQUENT_RESUME_WITHIN_EXECUTECOMMANDLISTS                                   = 1210,
    D3D12_MESSAGE_ID_TRACKED_WORKLOAD_COMMAND_QUEUE_MISMATCH                                                       = 1211,
    D3D12_MESSAGE_ID_TRACKED_WORKLOAD_NOT_SUPPORTED                                                                = 1212,
    D3D12_MESSAGE_ID_RENDER_PASS_MISMATCHING_NO_ACCESS                                                             = 1213,
    D3D12_MESSAGE_ID_RENDER_PASS_UNSUPPORTED_RESOLVE                                                               = 1214,
    D3D12_MESSAGE_ID_CLEARUNORDEREDACCESSVIEW_INVALID_RESOURCE_PTR                                                 = 1215,
    D3D12_MESSAGE_ID_WINDOWS7_FENCE_OUTOFORDER_SIGNAL                                                              = 1216,
    D3D12_MESSAGE_ID_WINDOWS7_FENCE_OUTOFORDER_WAIT                                                                = 1217,
    D3D12_MESSAGE_ID_VIDEO_CREATE_MOTION_ESTIMATOR_INVALID_ARGUMENT                                                = 1218,
    D3D12_MESSAGE_ID_VIDEO_CREATE_MOTION_VECTOR_HEAP_INVALID_ARGUMENT                                              = 1219,
    D3D12_MESSAGE_ID_ESTIMATE_MOTION_INVALID_ARGUMENT                                                              = 1220,
    D3D12_MESSAGE_ID_RESOLVE_MOTION_VECTOR_HEAP_INVALID_ARGUMENT                                                   = 1221,
    D3D12_MESSAGE_ID_GETGPUVIRTUALADDRESS_INVALID_HEAP_TYPE                                                        = 1222,
    D3D12_MESSAGE_ID_SET_BACKGROUND_PROCESSING_MODE_INVALID_ARGUMENT                                               = 1223,
    D3D12_MESSAGE_ID_CREATE_COMMAND_LIST_INVALID_COMMAND_LIST_TYPE_FOR_FEATURE_LEVEL                               = 1224,
    D3D12_MESSAGE_ID_CREATE_VIDEOEXTENSIONCOMMAND                                                                  = 1225,
    D3D12_MESSAGE_ID_LIVE_VIDEOEXTENSIONCOMMAND                                                                    = 1226,
    D3D12_MESSAGE_ID_DESTROY_VIDEOEXTENSIONCOMMAND                                                                 = 1227,
    D3D12_MESSAGE_ID_INVALID_VIDEO_EXTENSION_COMMAND_ID                                                            = 1228,
    D3D12_MESSAGE_ID_VIDEO_EXTENSION_COMMAND_INVALID_ARGUMENT                                                      = 1229,
    D3D12_MESSAGE_ID_CREATE_ROOT_SIGNATURE_NOT_UNIQUE_IN_DXIL_LIBRARY                                              = 1230,
    D3D12_MESSAGE_ID_VARIABLE_SHADING_RATE_NOT_ALLOWED_WITH_TIR                                                    = 1231,
    D3D12_MESSAGE_ID_GEOMETRY_SHADER_OUTPUTTING_BOTH_VIEWPORT_ARRAY_INDEX_AND_SHADING_RATE_NOT_SUPPORTED_ON_DEVICE = 1232,
    D3D12_MESSAGE_ID_RSSETSHADING_RATE_INVALID_SHADING_RATE                                                        = 1233,
    D3D12_MESSAGE_ID_RSSETSHADING_RATE_SHADING_RATE_NOT_PERMITTED_BY_CAP                                           = 1234,
    D3D12_MESSAGE_ID_RSSETSHADING_RATE_INVALID_COMBINER                                                            = 1235,
    D3D12_MESSAGE_ID_RSSETSHADINGRATEIMAGE_REQUIRES_TIER_2                                                         = 1236,
    D3D12_MESSAGE_ID_RSSETSHADINGRATE_REQUIRES_TIER_1                                                              = 1237,
    D3D12_MESSAGE_ID_SHADING_RATE_IMAGE_INCORRECT_FORMAT                                                           = 1238,
    D3D12_MESSAGE_ID_SHADING_RATE_IMAGE_INCORRECT_ARRAY_SIZE                                                       = 1239,
    D3D12_MESSAGE_ID_SHADING_RATE_IMAGE_INCORRECT_MIP_LEVEL                                                        = 1240,
    D3D12_MESSAGE_ID_SHADING_RATE_IMAGE_INCORRECT_SAMPLE_COUNT                                                     = 1241,
    D3D12_MESSAGE_ID_SHADING_RATE_IMAGE_INCORRECT_SAMPLE_QUALITY                                                   = 1242,
    D3D12_MESSAGE_ID_NON_RETAIL_SHADER_MODEL_WONT_VALIDATE                                                         = 1243,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_AS_ROOT_SIGNATURE_MISMATCH                                        = 1244,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_MS_ROOT_SIGNATURE_MISMATCH                                        = 1245,
    D3D12_MESSAGE_ID_ADD_TO_STATE_OBJECT_ERROR                                                                     = 1246,
    D3D12_MESSAGE_ID_CREATE_PROTECTED_RESOURCE_SESSION_INVALID_ARGUMENT                                            = 1247,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_MS_PSO_DESC_MISMATCH                                              = 1248,
    D3D12_MESSAGE_ID_CREATEPIPELINESTATE_MS_INCOMPLETE_TYPE                                                        = 1249,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_AS_NOT_MS_MISMATCH                                                = 1250,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_MS_NOT_PS_MISMATCH                                                = 1251,
    D3D12_MESSAGE_ID_NONZERO_SAMPLER_FEEDBACK_MIP_REGION_WITH_INCOMPATIBLE_FORMAT                                  = 1252,
    D3D12_MESSAGE_ID_CREATEGRAPHICSPIPELINESTATE_INPUTLAYOUT_SHADER_MISMATCH                                       = 1253,
    D3D12_MESSAGE_ID_EMPTY_DISPATCH                                                                                = 1254,
    D3D12_MESSAGE_ID_RESOURCE_FORMAT_REQUIRES_SAMPLER_FEEDBACK_CAPABILITY                                          = 1255,
    D3D12_MESSAGE_ID_SAMPLER_FEEDBACK_MAP_INVALID_MIP_REGION                                                       = 1256,
    D3D12_MESSAGE_ID_SAMPLER_FEEDBACK_MAP_INVALID_DIMENSION                                                        = 1257,
    D3D12_MESSAGE_ID_SAMPLER_FEEDBACK_MAP_INVALID_SAMPLE_COUNT                                                     = 1258,
    D3D12_MESSAGE_ID_SAMPLER_FEEDBACK_MAP_INVALID_SAMPLE_QUALITY                                                   = 1259,
    D3D12_MESSAGE_ID_SAMPLER_FEEDBACK_MAP_INVALID_LAYOUT                                                           = 1260,
    D3D12_MESSAGE_ID_SAMPLER_FEEDBACK_MAP_REQUIRES_UNORDERED_ACCESS_FLAG                                           = 1261,
    D3D12_MESSAGE_ID_SAMPLER_FEEDBACK_CREATE_UAV_NULL_ARGUMENTS                                                    = 1262,
    D3D12_MESSAGE_ID_SAMPLER_FEEDBACK_UAV_REQUIRES_SAMPLER_FEEDBACK_CAPABILITY                                     = 1263,
    D3D12_MESSAGE_ID_SAMPLER_FEEDBACK_CREATE_UAV_REQUIRES_FEEDBACK_MAP_FORMAT                                      = 1264,
    D3D12_MESSAGE_ID_CREATEMESHSHADER_INVALIDSHADERBYTECODE                                                        = 1265,
    D3D12_MESSAGE_ID_CREATEMESHSHADER_OUTOFMEMORY                                                                  = 1266,
    D3D12_MESSAGE_ID_CREATEMESHSHADERWITHSTREAMOUTPUT_INVALIDSHADERTYPE                                            = 1267,
    D3D12_MESSAGE_ID_RESOLVESUBRESOURCE_SAMPLER_FEEDBACK_TRANSCODE_INVALID_FORMAT                                  = 1268,
    D3D12_MESSAGE_ID_RESOLVESUBRESOURCE_SAMPLER_FEEDBACK_INVALID_MIP_LEVEL_COUNT                                   = 1269,
    D3D12_MESSAGE_ID_RESOLVESUBRESOURCE_SAMPLER_FEEDBACK_TRANSCODE_ARRAY_SIZE_MISMATCH                             = 1270,
    D3D12_MESSAGE_ID_SAMPLER_FEEDBACK_CREATE_UAV_MISMATCHING_TARGETED_RESOURCE                                     = 1271,
    D3D12_MESSAGE_ID_CREATEMESHSHADER_OUTPUTEXCEEDSMAXSIZE                                                         = 1272,
    D3D12_MESSAGE_ID_CREATEMESHSHADER_GROUPSHAREDEXCEEDSMAXSIZE                                                    = 1273,
    D3D12_MESSAGE_ID_VERTEX_SHADER_OUTPUTTING_BOTH_VIEWPORT_ARRAY_INDEX_AND_SHADING_RATE_NOT_SUPPORTED_ON_DEVICE   = 1274,
    D3D12_MESSAGE_ID_MESH_SHADER_OUTPUTTING_BOTH_VIEWPORT_ARRAY_INDEX_AND_SHADING_RATE_NOT_SUPPORTED_ON_DEVICE     = 1275,
    D3D12_MESSAGE_ID_CREATEMESHSHADER_MISMATCHEDASMSPAYLOADSIZE                                                    = 1276,
    D3D12_MESSAGE_ID_CREATE_ROOT_SIGNATURE_UNBOUNDED_STATIC_DESCRIPTORS                                            = 1277,
    D3D12_MESSAGE_ID_CREATEAMPLIFICATIONSHADER_INVALIDSHADERBYTECODE                                               = 1278,
    D3D12_MESSAGE_ID_CREATEAMPLIFICATIONSHADER_OUTOFMEMORY                                                         = 1279,
    D3D12_MESSAGE_ID_CREATE_SHADERCACHESESSION                                                                     = 1280,
    D3D12_MESSAGE_ID_LIVE_SHADERCACHESESSION                                                                       = 1281,
    D3D12_MESSAGE_ID_DESTROY_SHADERCACHESESSION                                                                    = 1282,
    D3D12_MESSAGE_ID_CREATESHADERCACHESESSION_INVALIDARGS                                                          = 1283,
    D3D12_MESSAGE_ID_CREATESHADERCACHESESSION_DISABLED                                                             = 1284,
    D3D12_MESSAGE_ID_CREATESHADERCACHESESSION_ALREADYOPEN                                                          = 1285,
    D3D12_MESSAGE_ID_SHADERCACHECONTROL_DEVELOPERMODE                                                              = 1286,
    D3D12_MESSAGE_ID_SHADERCACHECONTROL_INVALIDFLAGS                                                               = 1287,
    D3D12_MESSAGE_ID_SHADERCACHECONTROL_STATEALREADYSET                                                            = 1288,
    D3D12_MESSAGE_ID_SHADERCACHECONTROL_IGNOREDFLAG                                                                = 1289,
    D3D12_MESSAGE_ID_SHADERCACHESESSION_STOREVALUE_ALREADYPRESENT                                                  = 1290,
    D3D12_MESSAGE_ID_SHADERCACHESESSION_STOREVALUE_HASHCOLLISION                                                   = 1291,
    D3D12_MESSAGE_ID_SHADERCACHESESSION_STOREVALUE_CACHEFULL                                                       = 1292,
    D3D12_MESSAGE_ID_SHADERCACHESESSION_FINDVALUE_NOTFOUND                                                         = 1293,
    D3D12_MESSAGE_ID_SHADERCACHESESSION_CORRUPT                                                                    = 1294,
    D3D12_MESSAGE_ID_SHADERCACHESESSION_DISABLED                                                                   = 1295,
    D3D12_MESSAGE_ID_OVERSIZED_DISPATCH                                                                            = 1296,
    D3D12_MESSAGE_ID_CREATE_VIDEOENCODER                                                                           = 1297,
    D3D12_MESSAGE_ID_LIVE_VIDEOENCODER                                                                             = 1298,
    D3D12_MESSAGE_ID_DESTROY_VIDEOENCODER                                                                          = 1299,
    D3D12_MESSAGE_ID_CREATE_VIDEOENCODERHEAP                                                                       = 1300,
    D3D12_MESSAGE_ID_LIVE_VIDEOENCODERHEAP                                                                         = 1301,
    D3D12_MESSAGE_ID_DESTROY_VIDEOENCODERHEAP                                                                      = 1302,
    D3D12_MESSAGE_ID_COPYTEXTUREREGION_MISMATCH_ENCODE_REFERENCE_ONLY_FLAG                                         = 1303,
    D3D12_MESSAGE_ID_COPYRESOURCE_MISMATCH_ENCODE_REFERENCE_ONLY_FLAG                                              = 1304,
    D3D12_MESSAGE_ID_ENCODE_FRAME_INVALID_PARAMETERS                                                               = 1305,
    D3D12_MESSAGE_ID_ENCODE_FRAME_UNSUPPORTED_PARAMETERS                                                           = 1306,
    D3D12_MESSAGE_ID_RESOLVE_ENCODER_OUTPUT_METADATA_INVALID_PARAMETERS                                            = 1307,
    D3D12_MESSAGE_ID_RESOLVE_ENCODER_OUTPUT_METADATA_UNSUPPORTED_PARAMETERS                                        = 1308,
    D3D12_MESSAGE_ID_CREATE_VIDEO_ENCODER_INVALID_PARAMETERS                                                       = 1309,
    D3D12_MESSAGE_ID_CREATE_VIDEO_ENCODER_UNSUPPORTED_PARAMETERS                                                   = 1310,
    D3D12_MESSAGE_ID_CREATE_VIDEO_ENCODER_HEAP_INVALID_PARAMETERS                                                  = 1311,
    D3D12_MESSAGE_ID_CREATE_VIDEO_ENCODER_HEAP_UNSUPPORTED_PARAMETERS                                              = 1312,
    D3D12_MESSAGE_ID_CREATECOMMANDLIST_NULL_COMMANDALLOCATOR                                                       = 1313,
    D3D12_MESSAGE_ID_CLEAR_UNORDERED_ACCESS_VIEW_INVALID_DESCRIPTOR_HANDLE                                         = 1314,
    D3D12_MESSAGE_ID_DESCRIPTOR_HEAP_NOT_SHADER_VISIBLE                                                            = 1315,
    D3D12_MESSAGE_ID_CREATEBLENDSTATE_BLENDOP_WARNING                                                              = 1316,
    D3D12_MESSAGE_ID_CREATEBLENDSTATE_BLENDOPALPHA_WARNING                                                         = 1317,
    D3D12_MESSAGE_ID_WRITE_COMBINE_PERFORMANCE_WARNING                                                             = 1318,
    D3D12_MESSAGE_ID_RESOLVE_QUERY_INVALID_QUERY_STATE                                                             = 1319,
    D3D12_MESSAGE_ID_SETPRIVATEDATA_NO_ACCESS                                                                      = 1320,
    D3D12_MESSAGE_ID_COMMAND_LIST_STATIC_DESCRIPTOR_SAMPLER_MODE_MISMATCH                                          = 1321,
    D3D12_MESSAGE_ID_GETCOPYABLEFOOTPRINTS_UNSUPPORTED_BUFFER_WIDTH                                                = 1322,
    D3D12_MESSAGE_ID_CREATEMESHSHADER_TOPOLOGY_MISMATCH                                                            = 1323,
    D3D12_MESSAGE_ID_VRS_SUM_COMBINER_REQUIRES_CAPABILITY                                                          = 1324,
    D3D12_MESSAGE_ID_SETTING_SHADING_RATE_FROM_MS_REQUIRES_CAPABILITY                                              = 1325,
    D3D12_MESSAGE_ID_SHADERCACHESESSION_SHADERCACHEDELETE_NOTSUPPORTED                                             = 1326,
    D3D12_MESSAGE_ID_SHADERCACHECONTROL_SHADERCACHECLEAR_NOTSUPPORTED                                              = 1327,
    D3D12_MESSAGE_ID_CREATERESOURCE_STATE_IGNORED                                                                  = 1328,
    D3D12_MESSAGE_ID_UNUSED_CROSS_EXECUTE_SPLIT_BARRIER                                                            = 1329,
    D3D12_MESSAGE_ID_DEVICE_OPEN_SHARED_HANDLE_ACCESS_DENIED                                                       = 1330,
    D3D12_MESSAGE_ID_INCOMPATIBLE_BARRIER_VALUES                                                                   = 1331,
    D3D12_MESSAGE_ID_INCOMPATIBLE_BARRIER_ACCESS                                                                   = 1332,
    D3D12_MESSAGE_ID_INCOMPATIBLE_BARRIER_SYNC                                                                     = 1333,
    D3D12_MESSAGE_ID_INCOMPATIBLE_BARRIER_LAYOUT                                                                   = 1334,
    D3D12_MESSAGE_ID_INCOMPATIBLE_BARRIER_TYPE                                                                     = 1335,
    D3D12_MESSAGE_ID_OUT_OF_BOUNDS_BARRIER_SUBRESOURCE_RANGE                                                       = 1336,
    D3D12_MESSAGE_ID_INCOMPATIBLE_BARRIER_RESOURCE_DIMENSION                                                       = 1337,
    D3D12_MESSAGE_ID_SET_SCISSOR_RECTS_INVALID_RECT                                                                = 1338,
    D3D12_MESSAGE_ID_SHADING_RATE_SOURCE_REQUIRES_DIMENSION_TEXTURE2D                                              = 1339,
    D3D12_MESSAGE_ID_BUFFER_BARRIER_SUBREGION_OUT_OF_BOUNDS                                                        = 1340,
    D3D12_MESSAGE_ID_UNSUPPORTED_BARRIER_LAYOUT                                                                    = 1341,
    D3D12_MESSAGE_ID_CREATERESOURCEANDHEAP_INVALID_PARAMETERS                                                      = 1342,
    D3D12_MESSAGE_ID_ENHANCED_BARRIERS_NOT_SUPPORTED                                                               = 1343,
    D3D12_MESSAGE_ID_CAST_TARGET_TEXEL_SIZE_MISMATCH                                                               = 1344,
    D3D12_MESSAGE_ID_CAST_TO_PLANAR_NOT_SUPORTED                                                                   = 1345,
    D3D12_MESSAGE_ID_LEGACY_BARRIER_VALIDATION_FORCED_ON                                                           = 1346,
    D3D12_MESSAGE_ID_EMPTY_ROOT_DESCRIPTOR_TABLE                                                                   = 1347,
    D3D12_MESSAGE_ID_COMMAND_LIST_DRAW_ELEMENT_OFFSET_UNALIGNED                                                    = 1348,
    D3D12_MESSAGE_ID_ALPHA_BLEND_FACTOR_NOT_SUPPORTED                                                              = 1349,
    D3D12_MESSAGE_ID_D3D12_MESSAGES_END
  );
  {$EXTERNALSYM D3D12_MESSAGE_ID}


  PD3D12_MESSAGE = ^D3D12_MESSAGE;
  D3D12_MESSAGE = record
    Category: D3D12_MESSAGE_CATEGORY;
    Severity: D3D12_MESSAGE_SEVERITY;
    ID: D3D12_MESSAGE_ID;
    pDescription: PChar;
    DescriptionByteLength: SIZE_T;
  end;
  {$EXTERNALSYM D3D12_MESSAGE}


  PD3D12_INFO_QUEUE_FILTER_DESC = ^D3D12_INFO_QUEUE_FILTER_DESC;
  D3D12_INFO_QUEUE_FILTER_DESC = record
    NumCategories: UINT;
    pCategoryList: PD3D12_MESSAGE_CATEGORY;
    NumSeverities: UINT;
    pSeverityList: PD3D12_MESSAGE_SEVERITY;
    NumIDs: UINT;
    pIDList: PD3D12_MESSAGE_ID;
  end;
  {$EXTERNALSYM D3D12_INFO_QUEUE_FILTER_DESC}


  // To use, memset to 0, then fill in what you need.
  PD3D12_INFO_QUEUE_FILTER = ^D3D12_INFO_QUEUE_FILTER;
  D3D12_INFO_QUEUE_FILTER = record
    AllowList: D3D12_INFO_QUEUE_FILTER_DESC;
    DenyList: D3D12_INFO_QUEUE_FILTER_DESC;
  end;
  {$EXTERNALSYM D3D12_INFO_QUEUE_FILTER}


  //============================================================================
  // ID3D12InfoQueue
  //
  // Logs D3D12 Messages.
  // This interface can be queried from ID3D12Device, as long as the device
  // was created with the debug layer.
  //

const
  D3D12_INFO_QUEUE_DEFAULT_MESSAGE_COUNT_LIMIT = 1024;


type

  // Interface ID3D12InfoQueue
  // ==========================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D12InfoQueue);'}
  {$EXTERNALSYM ID3D12InfoQueue}
  ID3D12InfoQueue = Interface(IUnknown)
    ['{0742a90b-c387-483f-b946-30a7e4e61458}']

    //=========================================================================
    // Methods for configuring how much data is stored in the queue.

    // SetMessageCountLimit()
    // This sets how many messages are stored.  When the queue is full,
    // new messages coming in push old messages out.
    // Passing -1 to SetMessageCountLimit means the queue has
    // unlimited size (go until out of memory or ClearStoredMessages()).
    // The default message count size is
    // D3D12_INFO_QUEUE_DEFAULT_MESSAGE_COUNT_LIMIT
    // Returns S_OK or E_INVALIDARG.
    function SetMessageCountLimit(MessageCountLimit: UINT64): HRESULT; stdcall;

    // ClearStoredMessages
    procedure ClearStoredMessages(); stdcall;


    //=========================================================================
    // Methods for retrieving data or statistics from the queue.

    // GetMessage()
    // Retrieves messages, one at a time, from the queue which pass any
    // retrieval filter currently defined.  If there is no retrieval filter,
    // all messages can be retrieved.
    // The MessageIndex parameter is a 0 based index into the results passing
    // the filter.  The number of results is returned by
    // GetNumStoredMessagesAllowedByRetrievalFilter().
    //
    // Note this does not remove the message from the queue.
    //
    // pMessageByteLength inputs the size of the buffer passed in via
    // pMessage, and outputs the size of the message.  pMessage can be NULL
    // when the size of the required buffer is being queried (return S_FALSE).
    //
    // NOTE: The returned buffer pMessage is NOT just the size of D3D12_MESSAGE,
    // it includes extra memory after the D3D12_MESSAGE for storing the string
    // description, which is pointed to from within D3D12_MESSAGE.  Therefore
    // applications should check the size needed for pMessage as described above.
    //
    // Watch out for thread safety when making consecutive calls first to
    // determine the buffer size required and then to pass in the buffer and
    // retrieve the message, and also between calling
    // GetNumStoredMessagesAllowedByRetrievalFilter() and enumerating through
    // the results via GetMessagE().
    //
    // Returns: S_OK, S_FALSE, E_INVALIDARG or E_OUTOFMEMORY.
    function GetMessage(MessageIndex: UINT64;
                        pMessage: PD3D12_MESSAGE;
                        var pMessageByteLength: SIZE_T): HRESULT; stdcall;

    // GetNumMessagesAllowedByStorageFilter()
    // Returns how many messages sent to the queue passed
    // whatever storage filter was active upon receipt of
    // the message.
    // This can be a larger value than the message count limit,
    // returned by GetMessageCountLimit(), since old messages are discarded
    // when the queue is full to prevent overflow.
    function GetNumMessagesAllowedByStorageFilter(): UINT64; stdcall;

    // GetNumMessagesDeniedByStorageFilter()
    function GetNumMessagesDeniedByStorageFilter(): UINT64; stdcall;

    // GetNumStoredMessages()
    // Returns how many messages are currently stored in the queue.
    function GetNumStoredMessages(): UINT64; stdcall;

    // GetNumStoredMessagesAllowedByRetrievalFilter()
    // Returns how many messages that are currently in the queue
    // pass any retrieval filter that is currently set.
    // The MessageIndex parameter to GetMessage() indexes
    // an array of this many results.
    function GetNumStoredMessagesAllowedByRetrievalFilter(): UINT64; stdcall;

    // GetNumMessagesDiscardedByMessageCountLimit()
    function GetNumMessagesDiscardedByMessageCountLimit(): UINT64; stdcall;

    // GetMessageCountLimit
    // This is how many messages can be stored in the queue.
    // When the queue is full, new messages coming in push old messages out.
    // -1 means there is no limit.
    function GetMessageCountLimit(): UINT64; stdcall;


    //=========================================================================
    // Methods for filtering what gets stored in the queue

    // AddStorageFilterEntries()
    // Adds to the existing entries at top of stack
    // Returns: S_OK, E_INVALIDARG or E_OUTOFMEMORY.
    function AddStorageFilterEntries(pFilter: D3D12_INFO_QUEUE_FILTER): HRESULT; stdcall;

    // GetStorageFilter()
    // Gets all entries at top of stack.
    // The application must allocate the output buffer.  The size required can be
    // queried by passing null for pFilter and looking at the returned
    // pFilterByteLength (HRESULT is S_FALSE). Note that D3D12_INFO_QUEUE_FILTER contains
    // pointers - these will point to locations within the same
    // contiguous buffer - *pFilterByteLength is the total storage needed for all
    // data.  So the application needs to only allocate/free the memory for pFilter.
    // Returns S_OK, S_FALSE, E_INVALIDARG or E_OUTOFMEMORY
    function GetStorageFilter(pFilter: PD3D12_INFO_QUEUE_FILTER;
                              var pFilterByteLength: SIZE_T): HRESULT; stdcall;

    // ClearStorageFilter()
    // Clears filter at the top of the stack (if there is one)
    procedure ClearStorageFilter();

    // PushEmptyStorageFilter()
    // Push an empty storage filter on the stack to allow local filtering changes.
    // For convenience, this is automatically called by SetStorageFilter()
    // if the stack is empty.  Thus if the stack is not needed, filters can be
    // defined without ever bothering to push or pop.
    // Returns S_OK or E_OUTOFMEMORY
    function PushEmptyStorageFilter(): HRESULT; stdcall;

    // PushCopyOfStorageFilter()
    // Push a copy of the current filter so that local modifications can be made
    // starting from what currently exists.
    // Returns S_OK or E_OUTOFMEMORY
    function PushCopyOfStorageFilter(): HRESULT; stdcall;

    // PushStorageFilter()
    // Push a filter passed as a parameter onto the stack.  This is
    // just a helper for calling PushEmptyStorageFilter() followed
    // by AddStorageFilterEntries()
    // Returns S_OK, E_INVALIDARG or E_OUTOFMEMORY.
    function PushStorageFilter(pFilter: PD3D12_INFO_QUEUE_FILTER): HRESULT; stdcall;

    // PopStorageFilter()
    // Pop the current storage filter off the stack (if there is one)
    procedure PopStorageFilter(); stdcall;

    // GetStorageFilterStackSize()
    function GetStorageFilterStackSize(): UINT; stdcall;


    //=========================================================================
    // Methods for filtering what gets read out of the queue by GetMessage().

    // AddRetrievalFilterEntries()
    // Adds to the existing entries at top of stack
    // Returns: S_OK, E_INVALIDARG or E_OUTOFMEMORY.
    function AddRetrievalFilterEntries(pFilter: PD3D12_INFO_QUEUE_FILTER): HRESULT; stdcall;

    // GetRetrievalFilter()
    // Gets all entries at top of stack.
    // The application must allocate the output buffer.  The size required can be
    // queried by passing null for pFilter and looking at the returned
    // pFilterByteLength (HRESULT is S_FALSE).  Note that D3D12_INFO_QUEUE_FILTER contains
    // pointers - these will point to locations within the same
    // contiguous buffer - *pFilterByteLength is the total storage needed for all
    // data.  So the application needs to only allocate/free the memory for pFilter.
    // Returns S_OK, S_FALSE, E_INVALIDARG or E_OUTOFMEMORY
    function GetRetrievalFilter(pFilter: PD3D12_INFO_QUEUE_FILTER;
                                var FilterByteLength: SIZE_T): HRESULT; stdcall;

    // ClearRetrievalFilter()
    // Clears filter at the top of the stack (if there is one)
    procedure ClearRetrievalFilter(); stdcall;

    // PushEmptyRetrievalFilter()
    // Push an empty storage filter on the stack to allow local filtering changes.
    // For convenience, this is automatically called by SetRetrievalFilter()
    // if the stack is empty.  Thus if the stack is not needed, filters can be
    // defined without ever bothering to push or pop.
    // Returns S_OK or E_OUTOFMEMORY
    function PushEmptyRetrievalFilter(): HRESULT; stdcall;

    // PushCopyOfRetrievalFilter()
    // Push a copy of the current filter so that local modifications can be made
    // starting from what currently exists.
    // Returns S_OK or E_OUTOFMEMORY
    function PushCopyOfRetrievalFilter(): HRESULT; stdcall;

    // PushRetrievalFilter()
    // Push a filter passed as a parameter onto the stack.  This is
    // just a helper for calling PushEmptyRetrievalFilter() followed
    // by AddRetrievalFilterEntries()
    // Returns S_OK, E_INVALIDARG or E_OUTOFMEMORY.
    function PushRetrievalFilter(pFilter: PD3D12_INFO_QUEUE_FILTER): HRESULT; stdcall;

    // PopRetrievalFilter()
    procedure PopRetrievalFilter(); stdcall;

    // GetRetrievalFilterStackSize()
    function GetRetrievalFilterStackSize(): UINT; stdcall;


    //=========================================================================
    //  Methods for adding entries to the queue.

    // AddMessage()
    // This is used by D3D12 components to log messages.  Nothing stops
    // applications from calling this, but it isn’t particularly useful.
    // If an application wishes to insert custom strings into the queue,
    // AddApplicationMessage() below is suggested.  See below.
    //
    // Returns S_OK, E_INVALIDARG or E_OUTOFMEMORY
    function AddMessage(Category: D3D12_MESSAGE_CATEGORY;
                        Severity: D3D12_MESSAGE_SEVERITY;
                        ID: D3D12_MESSAGE_ID;
                        pDescription: LPCSTR): HRESULT; stdcall;

    // AddApplicationMessage()
    // This is a convenience for applications that want
    // to insert strings of their own into the queue, perhaps to log issues
    // of its own, or to mark out points in time in the queue.  This
    // has the same effect as calling AddMessage() above with the
    // following settings:
    //          Category = D3D12_MESSAGE_CATEGORY_APPLICATION_DEFINED
    //          Severity = <app selects from D3D12_MESSAGE_SEVERITY>
    //          ID       = D3D12_MESSAGE_ID_STRING_FROM_APPLICATION
    //          pDescription = <application provided string>
    //
    // Returns S_OK, E_INVALIDARG or E_OUTOFMEMORY
    function AddApplicationMessage(Severity: D3D12_MESSAGE_SEVERITY;
                                   pDescription: LPCSTR): HRESULT; stdcall;


    //=========================================================================
    //  Methods for breaking on errors that pass the storage filter.

    function SetBreakOnCategory(Category: D3D12_MESSAGE_CATEGORY;
                                bEnable: BOOL): HRESULT; stdcall;

    function SetBreakOnSeverity(Severity: D3D12_MESSAGE_SEVERITY;
                                bEnable: BOOL): HRESULT; stdcall;

    function SetBreakOnID(ID: D3D12_MESSAGE_ID;
                          bEnable: BOOL): HRESULT; stdcall;

    function GetBreakOnCategory(Category: D3D12_MESSAGE_CATEGORY): BOOL; stdcall;

    function GetBreakOnSeverity(Severity: D3D12_MESSAGE_SEVERITY): BOOL; stdcall;

    function GetBreakOnID(ID: D3D12_MESSAGE_ID): BOOL; stdcall;


    //=========================================================================
    //  Methods for globally muting debug spte from the InfoQueue

    procedure SetMuteDebugOutput(bMut: BOOL); stdcall;

    function GetMuteDebugOutput(): BOOL; stdcall;

  end;
  IID_ID3D12InfoQueue = ID3D12InfoQueue;
  {$EXTERNALSYM IID_ID3D12InfoQueue}


type
  PD3D12_MESSAGE_CALLBACK_FLAGS = ^D3D12_MESSAGE_CALLBACK_FLAGS;
  D3D12_MESSAGE_CALLBACK_FLAGS = UINT;
  {$EXTERNALSYM D3D12_MESSAGE_CALLBACK_FLAGS}
const
    D3D12_MESSAGE_CALLBACK_FLAG_NONE      = D3D12_MESSAGE_CALLBACK_FLAGS($00);
    D3D12_MESSAGE_CALLBACK_IGNORE_FILTERS = D3D12_MESSAGE_CALLBACK_FLAGS($01);


type

  D3D12MessageFunc = procedure(Category: D3D12_MESSAGE_CATEGORY;
                               Severity: D3D12_MESSAGE_SEVERITY;
                               ID: D3D12_MESSAGE_ID;
                               pDescription: LPCSTR;
                               pContext: Pointer); stdcall;


  // Interface ID3D12InfoQueue1
  // ===========================
  //
  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ID3D12InfoQueue1);'}
  {$EXTERNALSYM ID3D12InfoQueue1}
  ID3D12InfoQueue1 = Interface(ID3D12InfoQueue)
    ['{2852dd88-b484-4c0c-b6b1-67168500e600}']

    function RegisterMessageCallback(CallbackFunc: D3D12MessageFunc;
                                     CallbackFilterFlags: D3D12_MESSAGE_CALLBACK_FLAGS;
                                     pContext: Pointer;
                                     var pCallbackCookie: PDWORD): HRESULT; stdcall;

    function UnregisterMessageCallback(CallbackCookie: DWORD): HRESULT; stdcall;


  end;
  IID_ID3D12InfoQueue1 = ID3D12InfoQueue1;
  {$EXTERNALSYM IID_ID3D12InfoQueue1}


implementation

const
  D3D12SDKLayersLib = 'd3d12SDKLayers.dll';

end.
