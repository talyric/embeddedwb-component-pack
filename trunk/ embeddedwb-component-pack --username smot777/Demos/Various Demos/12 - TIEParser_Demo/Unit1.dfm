object Form1: TForm1
  Left = 245
  Top = 240
  Width = 728
  Height = 474
  Caption = 'Text IE Parser Demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 154
    Width = 323
    Height = 128
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 720
    Height = 41
    Align = alTop
    TabOrder = 1
    object Go: TButton
      Left = 653
      Top = 11
      Width = 28
      Height = 22
      Caption = 'Go'
      TabOrder = 0
      OnClick = GoClick
    end
    object IEAddress1: TIEAddress
      Left = 8
      Top = 11
      Width = 639
      Height = 22
      About = 'TIEAddress. Help & Support: http://www.bsalsa.com/'
      ButtonColor = clBlack
      ButtonPressedColor = clBlack
      IconLeft = 4
      IconTop = 3
      ItemHeight = 16
      ParentBiDiMode = True
      TabOrder = 1
    end
  end
  object Memo3: TMemo
    Left = 334
    Top = 154
    Width = 344
    Height = 128
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object Memo4: TMemo
    Left = 334
    Top = 288
    Width = 344
    Height = 127
    Lines.Strings = (
      '')
    ScrollBars = ssBoth
    TabOrder = 3
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 421
    Width = 720
    Height = 19
    Panels = <
      item
        Width = 300
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object Memo5: TMemo
    Left = 8
    Top = 39
    Width = 670
    Height = 109
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 5
  end
  object memo2: TRichEditWB
    Left = 8
    Top = 288
    Width = 320
    Height = 127
    Hint = 
      'File Name: Untitled. | '#10#13'Position: Line:   1   Col:   1. | '#10#13'Mod' +
      'ified. | '#10#13'Caps Lock: Off. | '#10#13'NumLock: Off. | '#10#13'Insert: On. | '#10 +
      #13'Total Lines Count: 1. |'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Lines.Strings = (
      'memo2'#13)
    ParentFont = False
    ParentShowHint = False
    ScrollBars = ssBoth
    ShowHint = True
    TabOrder = 6
    WordWrap = False
    AutoNavigate = True
    FileName = 'Untitled'
    HighlightHTML = True
    HighlightURL = True
    HighlightXML = True
    RTFText = 
      '{\rtf1\ansi\deff0{\fonttbl{\f0\fnil Tahoma;}}'#13#10'{\colortbl ;\red0' +
      '\green0\blue0;}'#13#10'\viewkind4\uc1\pard\cf1\lang2055\f0\fs16 memo2\' +
      'par'#13#10'}'#13#10
    SupprtMoreThen64KB = False
    TextAlignment = taLeftJustify
    HideCaret = False
    Themes = tDefault
  end
  object IEParser1: TIEParser
    About = 'TIEParser from: http://www.bsalsa.com'
    LocalFileName = 'C:\newbook.htm'
    Messages.ErrorText = 'An error occured while '
    Messages.StartText = 'Please wait..'
    Messages.SuccessText = 'Done.'
    OnAnchor = IEParser1Anchor
    OnBusyStateChange = IEParser1BusyStateChange
    OnDocInfo = IEParser1DocInfo
    OnImage = IEParser1Image
    OnMeta = IEParser1Meta
    OnStatusText = IEParser1StatusText
    Left = 24
    Top = 64
  end
end
