object Form1: TForm1
  Left = 302
  Top = 201
  Width = 870
  Height = 749
  Caption = 'Frame Enum Grab Text'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 432
    Width = 862
    Height = 283
    Align = alBottom
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Memo2: TMemo
    Left = 0
    Top = 41
    Width = 862
    Height = 391
    Align = alClient
    TabOrder = 1
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 862
    Height = 41
    Align = alTop
    TabOrder = 2
    object chkoutertext: TRadioButton
      Left = 24
      Top = 8
      Width = 81
      Height = 17
      Caption = 'outertext'
      TabOrder = 0
    end
    object chkouterhtml: TRadioButton
      Left = 112
      Top = 8
      Width = 81
      Height = 17
      Caption = 'outerhtml'
      TabOrder = 1
    end
    object chkinnertext: TRadioButton
      Left = 192
      Top = 8
      Width = 81
      Height = 17
      Caption = 'innertext'
      TabOrder = 2
    end
    object Button1: TButton
      Left = 272
      Top = 8
      Width = 75
      Height = 25
      Caption = 'EnumText'
      TabOrder = 3
      OnClick = Button1Click
    end
  end
end
