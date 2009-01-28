object Form1: TForm1
  Left = 224
  Top = 228
  Caption = 'Form1'
  ClientHeight = 606
  ClientWidth = 879
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
  object SpeedButton1: TSpeedButton
    Left = 616
    Top = 56
    Width = 113
    Height = 22
    Caption = 'Form2.Show'
    OnClick = SpeedButton1Click
  end
  object Button1: TButton
    Left = 16
    Top = 80
    Width = 177
    Height = 25
    Caption = 'www.google.ch'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 512
    Top = 96
    Width = 75
    Height = 25
    Caption = 'FocusToDoc'
    TabOrder = 1
    OnClick = Button2Click
  end
  object EmbeddedWB1: TEmbeddedWB
    Left = 16
    Top = 128
    Width = 577
    Height = 425
    TabOrder = 2
    OnEnter = EmbeddedWB1Enter
    OnExit = EmbeddedWB1Exit
    OnDocumentComplete = EmbeddedWB1DocumentComplete
    DisableCtrlShortcuts = 'N'
    UserInterfaceOptions = [EnablesFormsAutoComplete, EnableThemes]
    About = ' EmbeddedWB http://bsalsa.com/'
    PrintOptions.Margins.Left = 19.050000000000000000
    PrintOptions.Margins.Right = 19.050000000000000000
    PrintOptions.Margins.Top = 19.050000000000000000
    PrintOptions.Margins.Bottom = 19.050000000000000000
    PrintOptions.Header = '&w&bSeite &p von &P'
    PrintOptions.HTMLHeader.Strings = (
      '<HTML></HTML>')
    PrintOptions.Footer = '&u&b&d'
    PrintOptions.Orientation = poPortrait
    ControlData = {
      4C000000021F0000810F00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Memo1: TMemo
    Left = 616
    Top = 88
    Width = 233
    Height = 465
    Lines.Strings = (
      'Memo1')
    TabOrder = 3
  end
  object ApplicationEvents1: TApplicationEvents
    OnMessage = ApplicationEvents1Message
    Left = 368
    Top = 184
  end
  object Timer1: TTimer
    Interval = 2000
    OnTimer = Timer1Timer
    Left = 440
    Top = 112
  end
end
