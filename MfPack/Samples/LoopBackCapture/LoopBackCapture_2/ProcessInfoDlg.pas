
//
// Copyright: � FactoryX. All rights reserved.
//
// Project: MfPack - CoreAudio - WASAPI
// Project location: https://sourceforge.net/projects/MFPack
//                   https://github.com/FactoryXCode/MfPack
// Module: ProcessInfoDlg.pas
// Kind: Pascal / Delphi unit
// Release date: 02-04-2023
// Language: ENU
//
// Revision Version: 3.1.5
// Description: Process Info Dialog lists a snapshot of running processes so
//              a user can pick a process.
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
//------------------------------------------------------------------------------
//
// Remarks: Requires Windows 10 or later.
//
// Related objects: -
// Related projects: MfPackX315
// Known Issues: -
//
// Compiler version: 23 up to 35
// SDK version: 10.0.22621.0
//
// Todo: -
//
//==============================================================================
// Source: -
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
unit ProcessInfoDlg;

interface

uses
  {Winapi}
  Winapi.Windows,
  Winapi.Messages,
  WinApi.TlHelp32,
  {System}
  System.SysUtils,
  System.Variants,
  System.Classes,
  {Vcl}
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Grids,
  Vcl.ExtCtrls,
  {Application}
  Common;

type
  TdlgProcessInfo = class(TForm)
    butOk: TButton;
    butCancel: TButton;
    Label1: TLabel;
    butRefresh: TButton;
    sgProcesses: TStringGrid;
    Bevel1: TBevel;
    cbxSort: TCheckBox;
    butSort: TButton;
    cbxSortOnColumn: TCheckBox;
    procedure butOkClick(Sender: TObject);
    procedure butCancelClick(Sender: TObject);
    procedure butRefreshClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure butSortClick(Sender: TObject);
  private
    { Private declarations }

    procedure InitProcList();

  public
    { Public declarations }

    SelectedPID: Integer;
    SelectedProcName: string;

  end;

var
  dlgProcessInfo: TdlgProcessInfo;

implementation

{$R *.dfm}

procedure TdlgProcessInfo.butCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;


procedure TdlgProcessInfo.butOkClick(Sender: TObject);
begin
  SelectedPID := StrToInt(sgProcesses.Cells[1,
                                            sgProcesses.Row]);
  SelectedProcName := sgProcesses.Cells[0,
                                        sgProcesses.Row];
  ModalResult := mrOk;
end;


procedure TdlgProcessInfo.butRefreshClick(Sender: TObject);

  // helper
  procedure PopulateCells(iIndex: Integer;
                          sName: string;
                          iPid: Integer);
  begin
    {Process name}
    sgProcesses.Cells[0, iIndex] := sName;
    {Process ID}
    sgProcesses.Cells[1, iIndex] := IntToStr(iPid);
  end;

var
 hHandle: THandle;
 lppe: TProcessEntry32;
 i: Integer;

begin

  i := 0;

  hHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,
                                      0);

  if (hHandle <> 0) then
    begin
      // Set the record to default values.
      lppe := Default(TProcessEntry32);
      // We must set the dwSize parameter first!
      lppe.dwSize := SizeOf(TProcessEntry32);

      {$IFDEF ConditionalExpressions}
        {$IF CompilerVersion > 31.0}
          sgProcesses.BeginUpdate();
        {$IFEND}
      {$ENDIF}

      if Process32First(hHandle,
                        lppe) then
        begin

          PopulateCells(i,
                        lppe.szExeFile,
                        lppe.th32ProcessID);

          while Process32Next(hHandle,
                              lppe) do
            begin
              inc(i);
              sgProcesses.RowCount := i;
              PopulateCells(i,
                            lppe.szExeFile,
                            lppe.th32ProcessID);
            end;
        end;

      {$IFDEF ConditionalExpressions}
        {$IF CompilerVersion > 31.0}
          sgProcesses.EndUpdate();
        {$IFEND}
      {$ENDIF}
      CloseHandle(hHandle);
    end;
end;


procedure TdlgProcessInfo.butSortClick(Sender: TObject);
var
  aCol: Integer;

begin
  if (sgProcesses.ColCount < 2) then
    Exit;

  if cbxSortOnColumn.Checked then
    aCol := 0
  else
    aCol := 1;

  SortStringgrid(sgProcesses,
                 aCol,
                 cbxSort.Checked);
end;


procedure TdlgProcessInfo.FormShow(Sender: TObject);
begin
  // Assume no selection for now.
  SelectedPID := -1;
  SelectedProcName := 'Unknown';
  InitProcList();
  butRefreshClick(Self);
end;


procedure TdlgProcessInfo.InitProcList();
begin

  sgProcesses.ColCount := 3;
  sgProcesses.RowCount := 1;

  // For some reason, the methods to dimension TStringGrid changed?
  {$IF CompilerVersion < 31.0}
  sgProcesses.ColWidths[0] := 200;
  sgProcesses.ColWidths[1] := 100;
  {$ELSE}
  sgProcesses.ColWidths[0] := 390;
  sgProcesses.ColWidths[1] := 190;
  {$ENDIF}

  sgProcesses.Width := sgProcesses.ColWidths[0] +
                       sgProcesses.ColWidths[1] +
                       (sgProcesses.BevelWidth * 2);

end;

end.
