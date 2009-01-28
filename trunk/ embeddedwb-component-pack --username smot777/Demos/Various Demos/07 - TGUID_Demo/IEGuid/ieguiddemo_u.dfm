object Form1: TForm1
  Left = 303
  Top = 272
  Width = 620
  Height = 473
  Caption = 'IEGUID demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 199
    Top = 45
    Width = 76
    Height = 13
    Caption = 'Query Interface:'
  end
  object Label2: TLabel
    Left = 199
    Top = 208
    Width = 70
    Height = 13
    Caption = 'Query Service:'
  end
  object Label3: TLabel
    Left = 199
    Top = 330
    Width = 36
    Height = 13
    Caption = 'Events:'
  end
  object Label4: TLabel
    Left = 437
    Top = 74
    Width = 137
    Height = 33
    AutoSize = False
    Caption = 'DblClick to place code on clipboard'
    WordWrap = True
  end
  object Label5: TLabel
    Left = 442
    Top = 220
    Width = 137
    Height = 33
    AutoSize = False
    Caption = 'DblClick to place code on clipboard'
    WordWrap = True
  end
  object Label6: TLabel
    Left = 8
    Top = 8
    Width = 576
    Height = 16
    Caption = 
      'First, create a IEGuid.txt files using the  Guid Creator, then c' +
      'opy the files to this App'#39' folder and start.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object TreeView1: TTreeView
    Left = -1
    Top = 30
    Width = 193
    Height = 401
    Indent = 19
    TabOrder = 0
    OnChange = TreeView1Change
  end
  object ListBox1: TListBox
    Left = 198
    Top = 64
    Width = 233
    Height = 138
    ItemHeight = 13
    TabOrder = 1
    OnDblClick = ListBox1DblClick
  end
  object ListBox2: TListBox
    Left = 199
    Top = 227
    Width = 232
    Height = 97
    ItemHeight = 13
    TabOrder = 2
    OnDblClick = ListBox2DblClick
  end
  object ListBox3: TListBox
    Left = 198
    Top = 349
    Width = 232
    Height = 82
    ItemHeight = 13
    TabOrder = 3
  end
  object GroupBox1: TGroupBox
    Left = 443
    Top = 113
    Width = 144
    Height = 89
    Caption = 'Include'
    TabOrder = 4
    object IUnknownBox: TCheckBox
      Left = 13
      Top = 18
      Width = 97
      Height = 17
      Caption = 'IUnknown'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = ServiceGroupClick
    end
    object IdispatchBox: TCheckBox
      Left = 13
      Top = 34
      Width = 97
      Height = 17
      Caption = 'IDispatch'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = ServiceGroupClick
    end
    object IdispatchExBox: TCheckBox
      Left = 13
      Top = 50
      Width = 97
      Height = 17
      Caption = 'IDispatchEx'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = ServiceGroupClick
    end
    object DispInterfacesBox: TCheckBox
      Left = 13
      Top = 66
      Width = 97
      Height = 17
      Caption = 'Dispinterfaces'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = ServiceGroupClick
    end
  end
  object ServiceGroup: TRadioGroup
    Left = 442
    Top = 259
    Width = 145
    Height = 52
    Caption = 'Service group'
    ItemIndex = 0
    Items.Strings = (
      'IID'
      'SID_STopLevelBrowser')
    TabOrder = 5
    OnClick = ServiceGroupClick
  end
  object Panel1: TPanel
    Left = 445
    Top = 349
    Width = 142
    Height = 82
    Caption = 'Panel1'
    TabOrder = 6
    object EmbeddedWB1: TEmbeddedWB
      Left = 1
      Top = 1
      Width = 140
      Height = 80
      Align = alClient
      TabOrder = 0
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
      UserAgent = 'Mozilla/4.0(Compatible-EmbeddedWB 14.58 http://bsalsa.com/ '
      ControlData = {
        4C0000005F080000100500000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
  end
end
