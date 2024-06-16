object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'WAS Loopback Capture Sample 3'
  ClientHeight = 479
  ClientWidth = 471
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 454
    Width = 471
    Height = 1
    Align = alBottom
    Shape = bsTopLine
    ExplicitTop = 439
    ExplicitWidth = 472
  end
  object lblStatus: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 458
    Width = 465
    Height = 18
    Align = alBottom
    AutoSize = False
    Caption = 'Start Capture'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
    ExplicitTop = 443
    ExplicitWidth = 466
  end
  object Panel3: TPanel
    Left = 8
    Top = 241
    Width = 454
    Height = 91
    Hint = 
      'The capture buffersize depending on the audiodevice specs and so' +
      'urce latency '
    Alignment = taLeftJustify
    BevelOuter = bvLowered
    Caption = '  Capture Buffer'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    VerticalAlignment = taAlignTop
    object lblBufferDuration: TLabel
      Left = 8
      Top = 46
      Width = 195
      Height = 13
      Caption = 'Capture buffer duration : 10 milliseconds'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblCaptureBufferDuration: TLabel
      Left = 114
      Top = 25
      Width = 216
      Height = 13
      Caption = 'Auto capture buffer duration: 10 milliseconds'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsItalic]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 384
      Top = 47
      Width = 38
      Height = 13
      Hint = 'Latency in milliseconds.'
      Caption = 'Latency'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object tbBufferDuration: TTrackBar
      Left = 1
      Top = 64
      Width = 374
      Height = 25
      Max = 100
      Position = 10
      TabOrder = 0
      OnChange = tbBufferDurationChange
    end
    object cbxAutoBufferSize: TCheckBox
      Left = 8
      Top = 24
      Width = 100
      Height = 16
      Caption = 'Auto buffer size.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = cbxAutoBufferSizeClick
    end
    object spedLatency: TSpinEdit
      Left = 384
      Top = 63
      Width = 51
      Height = 22
      Hint = 'Latency in milliseconds.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxValue = 1000
      MinValue = 0
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Value = 10
    end
  end
  object butStartStop: TButton
    Left = 6
    Top = 422
    Width = 85
    Height = 27
    Caption = 'Start capture'
    TabOrder = 4
    OnClick = butStartStopClick
  end
  object butPlayData: TButton
    Left = 97
    Top = 422
    Width = 80
    Height = 27
    Hint = 'Play recorded data.'
    Caption = 'Play data'
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    OnClick = butPlayDataClick
  end
  object Panel1: TPanel
    Left = 9
    Top = 29
    Width = 454
    Height = 209
    Alignment = taLeftJustify
    BevelOuter = bvLowered
    Caption = '  AudioEndpoint'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    VerticalAlignment = taAlignTop
    object Label4: TLabel
      Left = 7
      Top = 68
      Width = 25
      Height = 13
      Caption = 'Role'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 7
      Top = 150
      Width = 77
      Height = 13
      Caption = 'Other options'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object rbConsole: TRadioButton
      Left = 16
      Top = 83
      Width = 315
      Height = 17
      Hint = 'Console'
      ParentCustomHint = False
      Caption = 'Games, system notification sounds and voice commands.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnMouseUp = rbConsoleMouseUp
    end
    object rbMultimedia: TRadioButton
      Left = 16
      Top = 104
      Width = 315
      Height = 17
      Hint = 'Multimedia'
      Caption = 'Music, movies, narration and live music recording.'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TabStop = True
      OnMouseUp = rbConsoleMouseUp
    end
    object rbCommunications: TRadioButton
      Left = 16
      Top = 125
      Width = 315
      Height = 17
      Hint = 'Communications'
      Caption = 'Voice communications (talking to another person).'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnMouseUp = rbConsoleMouseUp
    end
    object cbxDisableMmcss: TCheckBox
      Left = 16
      Top = 169
      Width = 194
      Height = 14
      Caption = 'Disable the use of MMCSS.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object Panel2: TPanel
      Left = 4
      Top = 25
      Width = 452
      Height = 43
      Alignment = taLeftJustify
      BevelOuter = bvNone
      TabOrder = 4
      object Label3: TLabel
        Left = 4
        Top = 2
        Width = 53
        Height = 13
        Caption = 'Data flow'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object rbRenderingDevice: TRadioButton
        Left = 12
        Top = 18
        Width = 145
        Height = 17
        Hint = 'Render'
        Caption = 'Audio rendering stream.'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        TabStop = True
      end
      object rbCaptureDevice: TRadioButton
        Left = 172
        Top = 18
        Width = 145
        Height = 17
        Hint = 'Capture'
        Caption = 'Audio capture stream.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
      object butShowdlgDevices: TButton
        Left = 341
        Top = 14
        Width = 97
        Height = 25
        Caption = 'Show Devices'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = butShowdlgDevicesClick
      end
    end
    object cbxEnableStreamSwitch: TCheckBox
      Left = 202
      Top = 169
      Width = 194
      Height = 14
      Caption = 'Enable stream switch.'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      State = cbChecked
      TabOrder = 5
    end
    object cbxUseDeviceAudioFmt: TCheckBox
      Left = 16
      Top = 189
      Width = 229
      Height = 14
      Hint = 'Will be set in Create.'
      Caption = 'Use PCM audio output format.'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 6
    end
  end
  object cbxStayOnTop: TCheckBox
    Left = 16
    Top = 8
    Width = 140
    Height = 15
    Caption = 'Stay On Top'
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    OnClick = cbxStayOnTopClick
  end
  object Panel4: TPanel
    Left = 8
    Top = 336
    Width = 454
    Height = 81
    BevelOuter = bvLowered
    TabOrder = 3
    object Label1: TLabel
      Left = 10
      Top = 32
      Width = 79
      Height = 13
      Hint = 'Enter a file name without extension.'
      AutoSize = False
      Caption = 'FileName'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object lblFileExt: TLabel
      Left = 405
      Top = 51
      Width = 44
      Height = 21
      Hint = 'Enter a file name without extension.'
      AutoSize = False
      Caption = '.wav'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      Transparent = False
    end
    object edFileName: TEdit
      Left = 9
      Top = 51
      Width = 395
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'WAS-capture'
      OnKeyUp = edFileNameKeyUp
    end
    object cbxDontOverWrite: TCheckBox
      Left = 9
      Top = 11
      Width = 189
      Height = 15
      Hint = 'Do not overwrite files with the same name.'
      Caption = 'Don'#39't overwrite excisting files'
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 0
    end
  end
  object butResetEngine: TButton
    Left = 382
    Top = 422
    Width = 80
    Height = 27
    Hint = 'Reset the engine when having issues.'
    Caption = 'Reset engine'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = butResetEngineClick
  end
end