object Form1: TForm1
  Left = 329
  Top = 245
  Width = 611
  Height = 623
  Caption = 'RightClick & Sortcuts Demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object EmbeddedWB1: TEmbeddedWB
    Left = 0
    Top = 0
    Width = 603
    Height = 569
    Align = alClient
    PopupMenu = PopupMenu1
    TabOrder = 0
    DisableCtrlShortcuts = 'N'
    UserInterfaceOptions = [EnablesFormsAutoComplete, EnableThemes]
    OnShowContextMenu = EmbeddedWB1ShowContextMenu
    About = ' EmbeddedWB http://bsalsa.com/'
    HTMLCode.Strings = (
      'http://bsalsa.com/')
    PrintOptions.Margins.Left = 19.05
    PrintOptions.Margins.Right = 19.05
    PrintOptions.Margins.Top = 19.05
    PrintOptions.Margins.Bottom = 19.05
    PrintOptions.Header = '&w&bSeite &p von &P'
    PrintOptions.HTMLHeader.Strings = (
      '<HTML></HTML>')
    PrintOptions.Footer = '&u&b&d'
    PrintOptions.Orientation = poPortrait
    UserAgent = 'EmbeddedWB 14.55 from: http://www.bsalsa.com/'
    ControlData = {
      4C000000072C0000732600000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object MainMenu1: TMainMenu
    Left = 8
    Top = 8
    object File1: TMenuItem
      Caption = '&File'
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
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
      object EnableAllMenus: TMenuItem
        AutoCheck = True
        Caption = 'Enable All Menus'
        Checked = True
        GroupIndex = 1
        RadioItem = True
      end
      object DisableAllMenu1: TMenuItem
        AutoCheck = True
        Caption = 'Disable All Menus'
        GroupIndex = 1
        RadioItem = True
      end
      object N3: TMenuItem
        AutoCheck = True
        Caption = '-'
        GroupIndex = 1
      end
      object DisableDefaultMenu1: TMenuItem
        AutoCheck = True
        Caption = 'Disable Default Menu (Document)'
        GroupIndex = 2
      end
      object DisableImagesMenu1: TMenuItem
        AutoCheck = True
        Caption = 'Disable Images Menu'
        GroupIndex = 2
      end
      object DisableTableMenu1: TMenuItem
        AutoCheck = True
        Caption = 'Disable Table Menu'
        GroupIndex = 2
      end
      object DisableSelectedTextMenu1: TMenuItem
        AutoCheck = True
        Caption = 'Disable Selected Text Menu'
        GroupIndex = 2
      end
      object DisableControlsMenu1: TMenuItem
        AutoCheck = True
        Caption = 'Disable Controls Menu (TEdit..)'
        GroupIndex = 2
      end
      object DisableAnchorMenu1: TMenuItem
        AutoCheck = True
        Caption = 'Disable Anchor Menu (Links..)'
        GroupIndex = 2
      end
      object DisableUnknownMenu1: TMenuItem
        AutoCheck = True
        Caption = 'Disable Unknown Menu'
        GroupIndex = 2
      end
      object DisableImgDynSrcMenu1: TMenuItem
        AutoCheck = True
        Caption = 'Disable ImgDynSrc Menu'
        GroupIndex = 2
      end
      object DisableDebugMenu1: TMenuItem
        AutoCheck = True
        Caption = 'Disable Debug Menu'
        GroupIndex = 2
      end
      object DisableImageArtMenu1: TMenuItem
        AutoCheck = True
        Caption = 'Disable Image Art Menu'
        GroupIndex = 2
      end
      object N1: TMenuItem
        Caption = '-'
        GroupIndex = 2
      end
      object N4: TMenuItem
        Caption = '------------------------'
        GroupIndex = 3
      end
      object Note1: TMenuItem
        Caption = 'NOTE: You can disable any menu item.'
        GroupIndex = 3
      end
      object Note2: TMenuItem
        Caption = 'See the source code for details!'
        GroupIndex = 3
      end
      object N2: TMenuItem
        Caption = '------------------------'
        GroupIndex = 3
      end
      object DisableViewSource1: TMenuItem
        AutoCheck = True
        Caption = 'Disable View Source'
        GroupIndex = 4
        ShortCut = 114
      end
      object DisableOpenInANewWindow1: TMenuItem
        AutoCheck = True
        Caption = 'Disable Open In A New Window'
        GroupIndex = 4
      end
      object DisableOpenLink1: TMenuItem
        AutoCheck = True
        Caption = 'Disable Open Link'
        GroupIndex = 4
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
        OnClick = DisableCtrlP1Click
      end
      object DisableCtrlA1: TMenuItem
        AutoCheck = True
        Caption = 'Disable Ctrl+A'
        GroupIndex = 1
        RadioItem = True
        ShortCut = 49217
        OnClick = DisableCtrlA1Click
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
        OnClick = EnableAll1Click
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 56
    Top = 8
    object wer1: TMenuItem
      Caption = 'Own Popup Menu!'
    end
  end
end
