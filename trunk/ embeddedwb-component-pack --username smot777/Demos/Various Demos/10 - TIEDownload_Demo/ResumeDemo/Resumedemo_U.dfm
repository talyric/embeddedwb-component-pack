object Form1: TForm1
  Left = 440
  Top = 219
  Width = 519
  Height = 299
  Caption = 'Resume Demo (IEDownload)'
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
    Left = 136
    Top = 216
    Width = 88
    Height = 13
    Caption = 'Estimated time left:'
  end
  object MemoLog: TMemo
    Left = 8
    Top = 16
    Width = 478
    Height = 161
    TabOrder = 0
  end
  object Button1: TButton
    Left = 10
    Top = 212
    Width = 115
    Height = 25
    Caption = 'Start Download'
    TabOrder = 1
    OnClick = Button1Click
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 184
    Width = 478
    Height = 17
    Min = 0
    Max = 100
    TabOrder = 2
  end
  object IEDownload1: TIEDownload
    AdditionalHeader.Strings = (
      'Content-Type: application/x-www-form-urlencoded')
    DefaultProtocol = 'http://'
    DefaultUrlFileName = 'index.html'
    OnDownloadComplete = IEDownload1DownloadComplete
    OnErrorText = IEDownload1ErrorText
    OnProgress = IEDownload1Progress
    OnRespondText = IEDownload1RespondText
    OnResponse = IEDownload1Response
    OnStatusText = IEDownload1StatusText
    UserAgent = 'Mozilla/4.0 (compatible; MSIE 6.0; Win32)'
    Left = 448
    Top = 32
  end
end
