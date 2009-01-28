object Form1: TForm1
  Left = 304
  Top = 258
  Width = 822
  Height = 533
  Caption = 'Zones & Security Demo'
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
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 7
    Top = 389
    Width = 98
    Height = 13
    Caption = 'Current template:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 7
    Top = 410
    Width = 105
    Height = 13
    Caption = 'Minimum template:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 7
    Top = 432
    Width = 109
    Height = 13
    Caption = 'Recomm. template:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object StringGrid1: TStringGrid
    Left = 0
    Top = 0
    Width = 537
    Height = 377
    ColCount = 2
    DefaultColWidth = 265
    DefaultRowHeight = 16
    FixedCols = 0
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    ParentFont = False
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 118
    Top = 385
    Width = 297
    Height = 22
    BevelInner = bvLowered
    TabOrder = 1
    object CurrentImage: TImage
      Left = 5
      Top = 3
      Width = 16
      Height = 16
    end
    object CurrentDisplay: TLabel
      Left = 28
      Top = 5
      Width = 3
      Height = 13
    end
  end
  object Panel2: TPanel
    Left = 118
    Top = 407
    Width = 297
    Height = 22
    BevelInner = bvLowered
    TabOrder = 2
    object MinimumImage: TImage
      Left = 5
      Top = 3
      Width = 16
      Height = 16
    end
    object MinimumDisplay: TLabel
      Left = 28
      Top = 5
      Width = 3
      Height = 13
    end
  end
  object Panel3: TPanel
    Left = 118
    Top = 429
    Width = 297
    Height = 22
    BevelInner = bvLowered
    TabOrder = 3
    object RecommImage: TImage
      Left = 5
      Top = 3
      Width = 16
      Height = 16
    end
    object RecommDisplay: TLabel
      Left = 27
      Top = 5
      Width = 3
      Height = 13
    end
  end
  object Button1: TButton
    Left = 457
    Top = 469
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Panel4: TPanel
    Left = 547
    Top = 0
    Width = 267
    Height = 499
    Align = alRight
    BevelOuter = bvNone
    Caption = 'Panel4'
    TabOrder = 5
    object Label2: TLabel
      Left = 39
      Top = 245
      Width = 204
      Height = 13
      Caption = 'Sites or urlpatterns added to selected zone:'
    end
    object Label4: TLabel
      Left = 156
      Top = 24
      Width = 88
      Height = 13
      Caption = 'Select Urlzone:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Memo1: TMemo
      Left = 19
      Top = 272
      Width = 225
      Height = 193
      ReadOnly = True
      TabOrder = 0
    end
    object ListView1: TListView
      Left = 40
      Top = 40
      Width = 204
      Height = 177
      Columns = <
        item
          AutoSize = True
        end>
      ReadOnly = True
      TabOrder = 1
      ViewStyle = vsReport
      OnSelectItem = ListView1SelectItem
    end
  end
end
