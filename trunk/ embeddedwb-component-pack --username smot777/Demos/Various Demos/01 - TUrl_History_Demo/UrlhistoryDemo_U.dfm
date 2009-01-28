object Form1: TForm1
  Left = 267
  Top = 287
  Width = 836
  Height = 544
  Caption = 'TUrlHistory Demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 480
    Top = 397
    Width = 25
    Height = 13
    Caption = 'Filter:'
  end
  object Label2: TLabel
    Left = 232
    Top = 376
    Width = 36
    Height = 13
    Caption = 'Sort by:'
  end
  object StringGrid1: TStringGrid
    Left = 0
    Top = 0
    Width = 828
    Height = 443
    Align = alClient
    DefaultColWidth = 75
    DefaultRowHeight = 16
    FixedCols = 0
    TabOrder = 0
    ColWidths = (
      114
      234
      222
      112
      107)
  end
  object Panel1: TPanel
    Left = 0
    Top = 443
    Width = 828
    Height = 67
    Align = alBottom
    TabOrder = 1
    object Label3: TLabel
      Left = 184
      Top = 24
      Width = 58
      Height = 13
      Caption = 'Search Text'
    end
    object Button1: TButton
      Left = 16
      Top = 18
      Width = 153
      Height = 25
      Caption = 'Enumerate !'
      TabOrder = 0
      OnClick = Button1Click
    end
    object ComboBox1: TComboBox
      Left = 496
      Top = 18
      Width = 145
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      Text = 'Last vistited'
      Items.Strings = (
        'Last visted'
        'Title'
        'Url'
        'Last updated'
        'Expires')
    end
    object CheckBox1: TCheckBox
      Left = 497
      Top = 43
      Width = 137
      Height = 16
      Caption = 'Only sites visited today'
      TabOrder = 2
    end
    object edSearchText: TEdit
      Left = 256
      Top = 20
      Width = 153
      Height = 21
      TabOrder = 3
    end
  end
  object UrlHistory1: TUrlHistory
    OnAccept = UrlHistory1Accept
    SortField = sfLastVisited
    SearchField = seBoth
    SortDirection = sdAscending
    Left = 24
    Top = 400
  end
end
