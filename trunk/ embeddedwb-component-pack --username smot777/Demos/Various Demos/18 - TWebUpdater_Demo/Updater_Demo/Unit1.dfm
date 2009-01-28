object Form1: TForm1
  Left = 324
  Top = 393
  Width = 474
  Height = 368
  Caption = 'Webupdater Demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 298
    Width = 466
    Height = 17
    Align = alBottom
    Min = 0
    Max = 100
    TabOrder = 0
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 315
    Width = 466
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 466
    Height = 257
    Align = alClient
    Lines.Strings = (
      'This demo will demonstrate the TWebUpdater.'
      
        'The TWebUpdater will download a remote XML file, parse its data ' +
        'sections'
      'And will do the update procedure automatically.'
      ''
      '')
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 0
    Top = 257
    Width = 466
    Height = 41
    Align = alBottom
    TabOrder = 3
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 121
      Height = 25
      Caption = 'Start WebUpdater'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object WebUpdater1: TWebUpdater
    About = 'Application Updater by bsalsa : bsalsa@bsalsa.com'
    AbortMessage = 'Aborted! (User request).'
    AppCurrentVer = 0.001
    ApplicationName = 'project1'
    Author = 'bsalsa'
    BackupFolder = 'Backup\'
    Caption = 'Updating the application... Please wait.'
    Company = 'bsalsa Productions'
    DeleteLogOnComplete = False
    EMail = 'bsalsa@bsalsa.com'
    ErrorMessage = 'An error ocurred while '
    LogAddTime = True
    LogFileName = 'Updater.txt'
    MailErrorReport = False
    OpenAppFolderOnComplete = True
    ProgressBar = ProgressBar1
    ShowUpdateFilesList = True
    StatusBar = StatusBar1
    SuccessMessageText = 'Update is done.'
    UpdatesFolder = 'Updates\'
    WebInfoFileName = 'Update.xml'
    WebURL = 'http://bsalsa.com/webupdate'
    Left = 8
    Top = 216
  end
end
