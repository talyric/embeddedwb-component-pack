object Form1: TForm1
  Left = 327
  Top = 315
  Width = 579
  Height = 454
  Caption = 'TEmbeddedWB - Open In A New Window Demo (Tabs)'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 41
    Width = 571
    Height = 360
    Align = alClient
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnChange = PageControl1Change
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 571
    Height = 41
    Align = alTop
    TabOrder = 1
    DesignSize = (
      571
      41)
    object Button1: TButton
      Left = 348
      Top = 11
      Width = 52
      Height = 22
      Anchors = [akTop]
      Caption = 'Go'
      TabOrder = 0
      OnClick = Button1Click
    end
    object IEAddress1: TIEAddress
      Left = 0
      Top = 11
      Width = 348
      Height = 22
      About = 'TIEAddress. Help & Support: http://www.bsalsa.com/'
      Anchors = [akLeft, akTop, akRight]
      ButtonColor = clBlack
      ButtonPressedColor = clBtnShadow
      IconLeft = 4
      IconTop = 3
      ItemHeight = 16
      ParentBiDiMode = True
      TabOrder = 1
      Text = 'http://www.bsalsa.com/'
      Items.Strings = (
        'http://www.bsalsa.com/'
        'http://leumi.co.il/'
        'http://www.sharekhan.com/sharekhanapplet/dummy.html'
        'http://www.bsalsa.com/Wimpie.rar'
        'Downloads/EmbeddedWB_D2005_Update14.2.zip'
        'http://www.bsalsa.com/forum/showthread.php?t=48'
        'google.com'
        'http://about: blank'
        'http://aboutblank'
        'http://altavista.com/'
        'http://delphi-jedi.org/')
    end
    object cbNewTab: TCheckBox
      Left = 429
      Top = 14
      Width = 121
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Open In A New Tab'
      Checked = True
      State = cbChecked
      TabOrder = 2
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 401
    Width = 571
    Height = 19
    Panels = <>
    SimplePanel = False
  end
end
