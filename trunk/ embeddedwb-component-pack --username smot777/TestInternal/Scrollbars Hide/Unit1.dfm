object Form1: TForm1
  Left = 304
  Top = 235
  Width = 952
  Height = 656
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object EWB: TEmbeddedWB
    Left = 16
    Top = 8
    Width = 529
    Height = 449
    TabOrder = 0
    OnDownloadComplete = EWBDownloadComplete
    DisableCtrlShortcuts = 'N'
    UserInterfaceOptions = [EnablesFormsAutoComplete, EnableThemes]
    About = ' EmbeddedWB http://bsalsa.com/'
    PrintOptions.HTMLHeader.Strings = (
      '<HTML></HTML>')
    PrintOptions.Orientation = poPortrait
    ControlData = {
      4C000000AC360000682E00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Button1: TButton
    Left = 16
    Top = 472
    Width = 75
    Height = 25
    Caption = 'Navigate'
    TabOrder = 1
    OnClick = Button1Click
  end
  object CheckBox1: TCheckBox
    Left = 568
    Top = 24
    Width = 137
    Height = 17
    Caption = 'AutoHideScrollBars1'
    TabOrder = 2
  end
  object CheckBox2: TCheckBox
    Left = 568
    Top = 56
    Width = 129
    Height = 17
    Caption = 'AutoHideScrollBars2'
    TabOrder = 3
  end
  object Button2: TButton
    Left = 568
    Top = 88
    Width = 129
    Height = 25
    Caption = 'Set'
    TabOrder = 4
    OnClick = Button2Click
  end
end
