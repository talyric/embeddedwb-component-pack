object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 563
  ClientWidth = 866
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 533
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Button1: TButton
    Left = 640
    Top = 511
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 608
    Top = 8
    Width = 233
    Height = 497
    ItemHeight = 13
    TabOrder = 1
  end
  object EmbeddedWB1: TEmbeddedWB
    Left = 24
    Top = 8
    Width = 553
    Height = 497
    TabOrder = 2
    DisableCtrlShortcuts = 'N'
    UserInterfaceOptions = [EnablesFormsAutoComplete, EnableThemes]
    OnTranslateAccelerator = EmbeddedWB1TranslateAccelerator
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
      4C000000273900005E3300000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object UpDown1: TUpDown
    Left = 432
    Top = 296
    Width = 17
    Height = 25
    TabOrder = 3
  end
  object Button2: TButton
    Left = 766
    Top = 511
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 4
    OnClick = Button2Click
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 448
    Top = 536
  end
  object ApplicationEvents1: TApplicationEvents
    OnMessage = ApplicationEvents1Message
    Left = 424
    Top = 296
  end
  object MainMenu1: TMainMenu
    Left = 8
    Top = 8
    object File1: TMenuItem
      Caption = '&File'
      object Exit1: TMenuItem
        Caption = 'Exit'
      end
    end
    object RightClickMenu1: TMenuItem
      Caption = '&RightClickMenu'
      object ShowMyPopup1: TMenuItem
        AutoCheck = True
        Caption = 'Show My Own Popup'
        GroupIndex = 1
        RadioItem = True
        ShortCut = 16466
      end
      object N5: TMenuItem
        AutoCheck = True
        Caption = '-'
        GroupIndex = 1
      end
      object EnableAllMenus: TMenuItem
        AutoCheck = True
        Caption = 'Enable All Menus'
        Checked = True
        GroupIndex = 1
        RadioItem = True
      end
      object N3: TMenuItem
        AutoCheck = True
        Caption = '-'
        GroupIndex = 1
      end
      object DisableAllMenu1: TMenuItem
        AutoCheck = True
        Caption = 'Disable All Menus'
        GroupIndex = 1
        ShortCut = 32837
        OnClick = DisableAllMenu1Click
      end
      object DisableDefaultMenu1: TMenuItem
        AutoCheck = True
        Caption = 'Disable Default Menu (Document)'
        GroupIndex = 1
      end
      object DisableImagesMenu1: TMenuItem
        AutoCheck = True
        Caption = 'Disable Images Menu'
        GroupIndex = 1
      end
      object DisableTableMenu1: TMenuItem
        AutoCheck = True
        Caption = 'Disable Table Menu'
        GroupIndex = 1
      end
      object DisableSelectedTextMenu1: TMenuItem
        AutoCheck = True
        Caption = 'Disable Selected Text Menu'
        GroupIndex = 1
      end
      object DisableControlsMenu1: TMenuItem
        AutoCheck = True
        Caption = 'Disable Controls Menu (TEdit..)'
        GroupIndex = 1
      end
      object DisableAnchorMenu1: TMenuItem
        AutoCheck = True
        Caption = 'Disable Anchor Menu (Links..)'
        GroupIndex = 1
      end
      object DisableUnknownMenu1: TMenuItem
        AutoCheck = True
        Caption = 'Disable Unknown Menu'
        GroupIndex = 1
      end
      object DisableImgDynSrcMenu1: TMenuItem
        AutoCheck = True
        Caption = 'Disable ImgDynSrc Menu'
        GroupIndex = 1
      end
      object DisableDebugMenu1: TMenuItem
        AutoCheck = True
        Caption = 'Disable Debug Menu'
        GroupIndex = 1
      end
      object DisableImageArtMenu1: TMenuItem
        AutoCheck = True
        Caption = 'Disable Image Art Menu'
        GroupIndex = 1
      end
      object N1: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object N4: TMenuItem
        Caption = '------------------------'
        GroupIndex = 1
      end
      object Note1: TMenuItem
        Caption = 'NOTE: You can disable any menu item.'
        GroupIndex = 1
      end
      object Note2: TMenuItem
        Caption = 'See the source code for details!'
        GroupIndex = 1
      end
      object N2: TMenuItem
        Caption = '------------------------'
        GroupIndex = 1
      end
      object DisableViewSource1: TMenuItem
        AutoCheck = True
        Caption = 'Disable View Source'
        GroupIndex = 1
        ShortCut = 114
        OnClick = DisableViewSource1Click
      end
      object DisableOpenInANewWindow1: TMenuItem
        AutoCheck = True
        Caption = 'Disable Open In A New Window'
        GroupIndex = 1
      end
      object DisableOpenLink1: TMenuItem
        AutoCheck = True
        Caption = 'Disable Open Link'
        GroupIndex = 1
      end
    end
    object Shortcuts1: TMenuItem
      Caption = '&Shortcuts'
      object DisableCtrlN1: TMenuItem
        AutoCheck = True
        Caption = 'Disable Ctrl+N'
        GroupIndex = 1
        RadioItem = True
        ShortCut = 49230
        OnClick = DisableCtrlN1Click
      end
      object DisableCtrlP1: TMenuItem
        AutoCheck = True
        Caption = 'Disable Ctrl+P'
        GroupIndex = 1
        RadioItem = True
        ShortCut = 49232
      end
      object DisableCtrlA1: TMenuItem
        AutoCheck = True
        Caption = 'Disable Ctrl+A'
        GroupIndex = 1
        RadioItem = True
        ShortCut = 49217
      end
      object N6: TMenuItem
        Caption = '-'
        GroupIndex = 1
      end
      object EnableAll1: TMenuItem
        AutoCheck = True
        Caption = 'Enable All Sortcuts'
        GroupIndex = 1
        RadioItem = True
        ShortCut = 49242
      end
    end
  end
end
