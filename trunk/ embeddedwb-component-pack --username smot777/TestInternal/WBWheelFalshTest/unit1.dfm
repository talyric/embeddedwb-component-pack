object Form1: TForm1
  Left = 185
  Top = 275
  Width = 1108
  Height = 656
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object EmbeddedWB1: TEmbeddedWB
    Left = 8
    Top = 7
    Width = 257
    Height = 250
    TabOrder = 0
    DisableCtrlShortcuts = 'N'
    UserInterfaceOptions = [EnablesFormsAutoComplete, EnableThemes]
    About = ' EmbeddedWB http://bsalsa.com/'
    HTMLCode.Strings = (
      'http://bsalsa.com/test/FlashTest.htm')
    OnMessage = EmbeddedWB1Message
    PrintOptions.Margins.Left = 19.05
    PrintOptions.Margins.Right = 19.05
    PrintOptions.Margins.Top = 19.05
    PrintOptions.Margins.Bottom = 19.05
    PrintOptions.Header = '&w&bSeite &p von &P'
    PrintOptions.HTMLHeader.Strings = (
      '<HTML></HTML>')
    PrintOptions.Footer = '&u&b&d'
    PrintOptions.Orientation = poPortrait
    OnKeyDown = EmbeddedWB1KeyDown
    OnKeyUp = EmbeddedWB1KeyUp
    OnMousePressed = EmbeddedWB1MousePressed
    ControlData = {
      4C000000F72600002F1B00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Button1: TButton
    Left = 559
    Top = 8
    Width = 105
    Height = 25
    Caption = 'Show Form2'
    TabOrder = 1
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 792
    Top = 24
    Width = 297
    Height = 193
    ItemHeight = 13
    Items.Strings = (
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9'
      '10'
      '11'
      '12'
      '13'
      '14'
      '15'
      '16'
      '17'
      '18'
      '19'
      '20')
    TabOrder = 2
  end
  object EmbeddedWB2: TEmbeddedWB
    Left = 272
    Top = 7
    Width = 257
    Height = 250
    TabOrder = 3
    DisableCtrlShortcuts = 'N'
    UserInterfaceOptions = [EnablesFormsAutoComplete, EnableThemes]
    About = ' EmbeddedWB http://bsalsa.com/'
    HTMLCode.Strings = (
      'http://bsalsa.com/test/FlashTest.htm')
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
      4C000000F72600002F1B00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Button2: TButton
    Left = 552
    Top = 72
    Width = 217
    Height = 25
    Caption = ' TEWBFocusControl.Activate(False);'
    TabOrder = 4
  end
  object Button3: TButton
    Left = 552
    Top = 112
    Width = 217
    Height = 25
    Caption = ' TEWBFocusControl.Activate(True);'
    TabOrder = 5
  end
  object Button4: TButton
    Left = 552
    Top = 168
    Width = 217
    Height = 25
    Caption = 'TEWBMouseHook.Activate(False);'
    TabOrder = 6
  end
  object Button5: TButton
    Left = 552
    Top = 208
    Width = 217
    Height = 25
    Caption = 'TEWBMouseHook.Activate(True);'
    TabOrder = 7
  end
  object ListBox2: TListBox
    Left = 0
    Top = 280
    Width = 1100
    Height = 342
    Align = alBottom
    ItemHeight = 13
    TabOrder = 8
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 160
    Top = 16
  end
end
