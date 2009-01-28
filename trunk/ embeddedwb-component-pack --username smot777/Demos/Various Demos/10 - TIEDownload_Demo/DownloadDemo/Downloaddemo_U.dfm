object Form1: TForm1
  Left = 341
  Top = 296
  Width = 664
  Height = 548
  Caption = 'Download Demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 495
    Width = 656
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Width = 200
      end
      item
        Width = 200
      end>
    SimplePanel = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 656
    Height = 41
    Align = alTop
    TabOrder = 1
    DesignSize = (
      656
      41)
    object btnStart: TButton
      Left = 347
      Top = 14
      Width = 63
      Height = 21
      Caption = 'Download'
      TabOrder = 0
      OnClick = btnStartClick
    end
    object btnStop: TButton
      Left = 416
      Top = 14
      Width = 57
      Height = 21
      Caption = 'Stop'
      TabOrder = 1
      OnClick = btnStopClick
    end
    object ProgressBar1: TProgressBar
      Left = 479
      Top = 14
      Width = 170
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Min = 0
      Max = 100
      TabOrder = 2
    end
    object EditURL: TEdit
      Left = 6
      Top = 13
      Width = 331
      Height = 21
      TabOrder = 3
      Text = 'http://www.bsalsa.com/nav/nav_1_index_bhb.gif'
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 249
    Height = 314
    Align = alLeft
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 21
      Height = 13
      Caption = 'Info:'
    end
    object Label2: TLabel
      Left = 8
      Top = 144
      Width = 75
      Height = 13
      Caption = 'Preview stream:'
    end
    object MemoInfo: TMemo
      Left = 4
      Top = 25
      Width = 239
      Height = 113
      ScrollBars = ssBoth
      TabOrder = 0
    end
    object MemoPreview: TMemo
      Left = 4
      Top = 163
      Width = 240
      Height = 142
      ScrollBars = ssBoth
      TabOrder = 1
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 355
    Width = 656
    Height = 140
    Align = alBottom
    Caption = 'Panel3'
    TabOrder = 3
    object ListView: TListView
      Left = 1
      Top = 1
      Width = 654
      Height = 138
      Align = alClient
      Columns = <
        item
          Caption = 'URL'
          Width = 160
        end
        item
          Caption = 'Speed'
          Width = 75
        end
        item
          Caption = 'Downloaded'
          Width = 75
        end
        item
          Caption = 'Remaining Time'
          Width = 90
        end
        item
          Caption = 'Elapsed Time'
          Width = 90
        end
        item
          Caption = 'Status'
          Width = 150
        end>
      GridLines = True
      HideSelection = False
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object Panel4: TPanel
    Left = 249
    Top = 41
    Width = 407
    Height = 314
    Align = alClient
    Caption = 'Panel4'
    TabOrder = 4
    object EmbeddedWB1: TEmbeddedWB
      Left = 1
      Top = 1
      Width = 405
      Height = 312
      Align = alClient
      TabOrder = 0
      DisableCtrlShortcuts = 'N'
      UserInterfaceOptions = [EnablesFormsAutoComplete, EnableThemes]
      About = ' EmbeddedWB http://bsalsa.com/'
      PrintOptions.Margins.Left = 19.05
      PrintOptions.Margins.Right = 19.05
      PrintOptions.Margins.Top = 19.05
      PrintOptions.Margins.Bottom = 19.05
      PrintOptions.Header = '&w&bSeite &p von &P'
      PrintOptions.HTMLHeader.Strings = (
        '<HTML></HTML>')
      PrintOptions.Footer = '&u&b&d'
      PrintOptions.Orientation = poPortrait
      UserAgent = 'EmbeddedWB 14.56 from: http://www.bsalsa.com/'
      ControlData = {
        4C000000852200000B1D00000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
  object IEDownload1: TIEDownload
    AdditionalHeader.Strings = (
      'Content-Type: application/x-www-form-urlencoded')
    DefaultProtocol = 'http://'
    DefaultUrlFileName = 'index.html'
    OnBeginningTransaction = IEDownload1BeginningTransaction
    OnBusyStateChange = IEDownload1BusyStateChange
    OnDataAvailable = IEDownload1DataAvailable
    OnDownloadComplete = IEDownload1DownloadComplete
    OnErrorText = IEDownload1ErrorText
    OnProgress = IEDownload1Progress
    OnRespondText = IEDownload1RespondText
    OnStatusText = IEDownload1StatusText
    Security.InheritHandle = True
    Left = 264
    Top = 48
  end
end
