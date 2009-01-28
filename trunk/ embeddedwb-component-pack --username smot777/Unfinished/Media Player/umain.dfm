object Form1: TForm1
  Left = 335
  Top = 371
  Width = 524
  Height = 361
  Caption = 'EWB Mediaplayer'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 516
    Height = 41
    Align = alTop
    TabOrder = 0
    object Button4: TButton
      Left = 251
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Rewind'
      TabOrder = 0
      OnClick = Button4Click
    end
    object Button3: TButton
      Left = 170
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Pause'
      TabOrder = 1
      OnClick = Button3Click
    end
    object Button2: TButton
      Left = 89
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Stop'
      TabOrder = 2
      OnClick = Button2Click
    end
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Start'
      TabOrder = 3
      OnClick = Button1Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 516
    Height = 286
    Align = alClient
    TabOrder = 1
    object EmbeddedWB1: TEmbeddedWB
      Left = 1
      Top = 1
      Width = 514
      Height = 284
      Align = alClient
      TabOrder = 0
      OnDocumentComplete = EmbeddedWB1DocumentComplete
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
        4C000000A52F0000CD1E00000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
end
