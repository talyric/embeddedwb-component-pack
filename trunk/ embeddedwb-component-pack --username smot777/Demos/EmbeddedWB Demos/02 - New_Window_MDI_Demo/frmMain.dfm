object MainFrm: TMainFrm
  Left = 344
  Top = 225
  Width = 659
  Height = 509
  Caption = 'TEmbeddedWB - MDI Demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  WindowMenu = N10
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 651
    Height = 41
    Align = alTop
    TabOrder = 0
    DesignSize = (
      651
      41)
    object IEAddress1: TIEAddress
      Left = 16
      Top = 8
      Width = 551
      Height = 22
      About = 'TIEAddress. Help & Support: http://www.bsalsa.com/'
      Anchors = [akLeft, akTop, akRight]
      ButtonColor = clBlack
      ButtonPressedColor = clBlack
      IconLeft = 4
      IconTop = 3
      ItemHeight = 16
      ParentBiDiMode = True
      TabOrder = 0
      Text = 'http://www.bsalsa.com/'
      TextOnLoad = tlUserDefine
      TextOnShow = 'http://www.bsalsa.com/'
      Themes = tmXP
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
    object Button1: TButton
      Left = 585
      Top = 8
      Width = 53
      Height = 22
      Anchors = [akTop]
      Caption = 'Go'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object MainMenu1: TMainMenu
    Left = 16
    Top = 48
    object File1: TMenuItem
      Caption = '&File'
      object Newchild1: TMenuItem
        Caption = 'New Child'
        OnClick = Newchild1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object CloseAll1: TMenuItem
        Caption = 'Close &All'
        OnClick = CloseAll1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object Window1: TMenuItem
      Caption = '&Window'
      object Cascade1: TMenuItem
        Caption = '&Cascade'
        OnClick = Cascade1Click
      end
      object Tile1: TMenuItem
        Caption = '&Tile'
        OnClick = Tile1Click
      end
      object ArrangeAll1: TMenuItem
        Caption = '&Arrange All'
        OnClick = ArrangeAll1Click
      end
      object N10: TMenuItem
        AutoHotkeys = maManual
        AutoLineReduction = maManual
        Caption = '-'
      end
      object MinimizeAll1: TMenuItem
        Caption = 'Minimize All'
        OnClick = MinimizeAll1Click
      end
    end
  end
  object Timer1: TTimer
    Left = 312
    Top = 240
  end
end
