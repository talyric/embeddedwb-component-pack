object Form1: TForm1
  Left = 314
  Top = 301
  Width = 818
  Height = 623
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object EmbeddedWB1: TEmbeddedWB
    Left = 201
    Top = 109
    Width = 609
    Height = 480
    Align = alClient
    TabOrder = 0
    OnWindowStateChanged = EmbeddedWB1WindowStateChanged
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
      4C000000942D0000012200000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object ListBox1: TListBox
    Left = 0
    Top = 109
    Width = 201
    Height = 480
    Align = alLeft
    BorderStyle = bsNone
    ItemHeight = 13
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 810
    Height = 109
    Align = alTop
    TabOrder = 2
    object Bevel1: TBevel
      Left = 2
      Top = 3
      Width = 216
      Height = 58
    end
    object Bevel2: TBevel
      Left = 224
      Top = 3
      Width = 408
      Height = 58
    end
    object Label1: TLabel
      Left = 648
      Top = 8
      Width = 30
      Height = 13
      Caption = 'Value:'
    end
    object Label2: TLabel
      Left = 520
      Top = 72
      Width = 32
      Height = 13
      Caption = 'Label2'
    end
    object Button2: TButton
      Left = 8
      Top = 72
      Width = 89
      Height = 25
      Caption = 'Fill from!'
      TabOrder = 0
      OnClick = Button2Click
    end
    object Button1: TButton
      Left = 104
      Top = 24
      Width = 97
      Height = 25
      Caption = 'Go Testpage'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button6: TButton
      Left = 8
      Top = 24
      Width = 89
      Height = 25
      Caption = 'Go Google'
      TabOrder = 2
      OnClick = Button6Click
    end
    object chkFieldType: TCheckBox
      Left = 495
      Top = 8
      Width = 118
      Height = 17
      Caption = 'Match FieldType'
      TabOrder = 3
    end
    object chkFieldName: TCheckBox
      Left = 236
      Top = 8
      Width = 121
      Height = 17
      Caption = 'Match FieldName'
      TabOrder = 4
    end
    object chkFieldValue: TCheckBox
      Left = 366
      Top = 8
      Width = 111
      Height = 17
      Caption = 'Match FieldValue'
      TabOrder = 5
    end
    object edFieldName: TEdit
      Left = 238
      Top = 32
      Width = 121
      Height = 21
      TabOrder = 6
    end
    object edFieldValue: TEdit
      Left = 366
      Top = 32
      Width = 121
      Height = 21
      TabOrder = 7
    end
    object cbElementType: TComboBox
      Left = 496
      Top = 32
      Width = 132
      Height = 21
      ItemHeight = 13
      TabOrder = 8
      Items.Strings = (
        'checkbox'
        'radio'
        'input'
        'select'
        'text')
    end
    object edNewValue: TEdit
      Left = 648
      Top = 32
      Width = 121
      Height = 21
      TabOrder = 9
    end
    object CheckBox1: TCheckBox
      Left = 232
      Top = 64
      Width = 97
      Height = 17
      Caption = 'CheckBox1'
      TabOrder = 10
    end
    object Edit1: TEdit
      Left = 240
      Top = 80
      Width = 121
      Height = 21
      TabOrder = 11
      Text = 'Edit1'
    end
    object Button3: TButton
      Left = 402
      Top = 78
      Width = 75
      Height = 25
      Caption = 'Button3'
      TabOrder = 12
      OnClick = Button3Click
    end
    object Button5: TButton
      Left = 710
      Top = 30
      Width = 75
      Height = 25
      Caption = 'Button3'
      TabOrder = 13
    end
  end
  object Button4: TButton
    Left = 710
    Top = 78
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button7: TButton
    Left = 688
    Top = 512
    Width = 75
    Height = 25
    Caption = 'Button7'
    TabOrder = 4
    OnClick = Button7Click
  end
  object FindDialog1: TFindDialog
    Left = 392
    Top = 296
  end
end
