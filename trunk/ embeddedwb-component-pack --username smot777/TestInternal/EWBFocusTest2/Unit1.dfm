object Form1: TForm1
  Left = 261
  Top = 232
  Width = 902
  Height = 657
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 185
    Top = 0
    Width = 544
    Height = 606
    Align = alClient
    ItemHeight = 13
    Items.Strings = (
      'TEST1'
      'TEST2'
      'TEST3'
      'TEST4'
      'TEST5'
      'TEST6'
      'TEST7'
      'TEST8'
      'TEST9'
      'TEST10'
      'TEST11'
      'TEST12'
      'TEST13'
      'TEST14'
      'TEST15'
      'TEST16'
      'TEST17'
      'TEST18'
      'TEST19'
      'TEST20')
    TabOrder = 0
    OnClick = ListBox1Click
  end
  object Button1: TButton
    Left = 328
    Top = 16
    Width = 113
    Height = 25
    Caption = 'www.google.com'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 328
    Top = 48
    Width = 113
    Height = 25
    Caption = 'c:\'
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 606
    Align = alLeft
    Caption = 'Panel1'
    TabOrder = 3
    object WebBrowser1: TEmbeddedWB
      Left = 1
      Top = 301
      Width = 183
      Height = 304
      Align = alClient
      TabOrder = 0
      Silent = False
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
      ControlData = {
        4C000000021F0000A23E00000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
    object WebBrowser2: TEmbeddedWB
      Left = 1
      Top = 1
      Width = 183
      Height = 300
      Align = alTop
      TabOrder = 1
      Silent = False
      DisableCtrlShortcuts = 'N'
      UserInterfaceOptions = [EnablesFormsAutoComplete, EnableThemes]
      About = ' EmbeddedWB http://bsalsa.com/'
      HTMLCode.Strings = (
        'www.google.com')
      PrintOptions.Margins.Left = 19.05
      PrintOptions.Margins.Right = 19.05
      PrintOptions.Margins.Top = 19.05
      PrintOptions.Margins.Bottom = 19.05
      PrintOptions.Header = '&w&bSeite &p von &P'
      PrintOptions.HTMLHeader.Strings = (
        '<HTML></HTML>')
      PrintOptions.Footer = '&u&b&d'
      PrintOptions.Orientation = poPortrait
      ControlData = {
        4C000000021F0000A23E00000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
    object Button5: TButton
      Left = 144
      Top = 8
      Width = 25
      Height = 25
      Caption = 'R'
      TabOrder = 2
      OnClick = Button5Click
    end
  end
  object ListBox2: TListBox
    Left = 729
    Top = 0
    Width = 198
    Height = 606
    Align = alRight
    ItemHeight = 13
    TabOrder = 4
  end
  object Button3: TButton
    Left = 328
    Top = 80
    Width = 113
    Height = 25
    Caption = 'ShowFindDialog'
    TabOrder = 5
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 328
    Top = 120
    Width = 113
    Height = 25
    Caption = 'Show Form2'
    TabOrder = 6
    OnClick = Button4Click
  end
  object Panel2: TPanel
    Left = 480
    Top = 16
    Width = 249
    Height = 89
    Caption = 'Panel2'
    TabOrder = 7
  end
  object Button8: TButton
    Left = 376
    Top = 296
    Width = 129
    Height = 25
    Caption = 'Button8'
    TabOrder = 8
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 592
    Top = 80
  end
end
