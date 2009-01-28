object Form1: TForm1
  Left = 373
  Top = 236
  Width = 418
  Height = 376
  Caption = 'File Association Demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 324
    Width = 410
    Height = 18
    Panels = <
      item
        Width = 170
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object Panel2: TPanel
    Left = 0
    Top = 271
    Width = 410
    Height = 53
    Align = alBottom
    TabOrder = 1
    object Image1: TImage
      Left = 332
      Top = 10
      Width = 41
      Height = 37
    end
    object Label5: TLabel
      Left = 133
      Top = 18
      Width = 51
      Height = 13
      Caption = 'Extension:'
    end
    object bttGetIcon: TButton
      Left = 6
      Top = 13
      Width = 121
      Height = 21
      Caption = 'Icon by extension'
      TabOrder = 0
      OnClick = bttGetIconClick
    end
    object edtIcon: TEdit
      Left = 190
      Top = 13
      Width = 121
      Height = 21
      TabOrder = 1
      Text = 'html'
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 410
    Height = 145
    Align = alTop
    TabOrder = 2
    object Label1: TLabel
      Left = 151
      Top = 16
      Width = 51
      Height = 13
      Caption = 'Extension:'
    end
    object Label2: TLabel
      Left = 151
      Top = 35
      Width = 47
      Height = 13
      Caption = 'Extension'
    end
    object Label3: TLabel
      Left = 151
      Top = 67
      Width = 51
      Height = 13
      Caption = 'Extension:'
    end
    object btnExecute: TButton
      Left = 11
      Top = 13
      Width = 105
      Height = 21
      Caption = 'Execute Extension'
      TabOrder = 0
      OnClick = btnExecuteClick
    end
    object btnRemove: TButton
      Left = 11
      Top = 40
      Width = 105
      Height = 21
      Caption = 'Remove Extension'
      TabOrder = 1
      OnClick = btnRemoveClick
    end
    object edtExt: TEdit
      Left = 208
      Top = 13
      Width = 177
      Height = 21
      TabOrder = 2
      Text = 'bsalsa'
    end
    object edtRemove: TEdit
      Left = 208
      Top = 40
      Width = 177
      Height = 21
      TabOrder = 3
    end
    object btnCheck: TButton
      Left = 11
      Top = 67
      Width = 105
      Height = 21
      Caption = 'Check Extensions'
      TabOrder = 4
      OnClick = btnCheckClick
    end
    object edtCheck: TEdit
      Left = 208
      Top = 67
      Width = 177
      Height = 21
      TabOrder = 5
    end
    object edtPath: TEdit
      Left = 6
      Top = 98
      Width = 379
      Height = 21
      TabOrder = 6
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 145
    Width = 410
    Height = 126
    Align = alClient
    TabOrder = 3
    object Image2: TImage
      Left = 332
      Top = 52
      Width = 41
      Height = 37
    end
    object Label4: TLabel
      Left = 317
      Top = 95
      Width = 68
      Height = 13
      Caption = 'Image Numer:'
    end
    object Label7: TLabel
      Left = 332
      Top = 33
      Width = 21
      Height = 13
      Caption = 'Icon'
    end
    object lbNum: TLabel
      Left = 344
      Top = 107
      Width = 29
      Height = 13
      Caption = 'lbNum'
    end
    object Memo1: TMemo
      Left = 11
      Top = 34
      Width = 300
      Height = 85
      Lines.Strings = (
        'Memo1')
      TabOrder = 0
    end
    object edtPath2: TEdit
      Left = 133
      Top = 6
      Width = 252
      Height = 21
      TabOrder = 1
    end
    object btnFileType: TButton
      Left = 8
      Top = 7
      Width = 119
      Height = 21
      Caption = 'File Info By Path'
      TabOrder = 2
      OnClick = btnFileTypeClick
    end
  end
  object FileExtAssociate1: TFileExtAssociate
    About = 
      'File Extension Associate component by bsalsa. Help & Support: ht' +
      'tp://www.bsalsa.com/'
    ExtensionAssociate.Extensions.Strings = (
      'bsalsa'
      'bsalsa1')
    ApplicationDetails.Title = 'File Extension Demo'
    ApplicationDetails.Icon.Data = {
      0000010001002020200000000000A81000001600000028000000200000004000
      0000010020000000000000100000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000AA9FAA00555F5500553F5500555F5500003F5500555F5500553F5500555F
      2A00553F5500555F5500553F5500553F5500555F5500553F5500555F55000000
      00000000000000000000005FAA00001F55000000000000000000000000000000
      00000000000000000000000000000000000000000000005F5500553F5500557F
      AA00555F550080808000FF7F5500AA5F5500AA5F5500AA5F5500AA5F5500555F
      550055BFD400559FAA0055BFD40000BFFF0055BFD400559FAA00553F55000000
      00000000000000000000559FD400557FAA00005F5500001F5500001F2A00001F
      550000002A00001F5500001F5500555F5500005F5500555FAA00557FAA0055BF
      D400555F5500FF7F5500A4A0A000AA7F5500AA5F5500AA5F2A00AA7F5500553F
      5500559FAA00557FAA0000BFFF0055DFD40000BFFF0055BFD400553F55000000
      0000000000000000000000000000005F7F00555FAA00557F7F00005FAA00005F
      7F00557FAA0000808000555FAA00005FAA00557FAA00559FAA00007FAA00AA9F
      D400555F7F00AA9F7F00FF9FAA00AA5F5500AA5F5500AA5F5500AA3F5500555F
      550055BFAA00559FD40055BFD40000BFFF0055DFD400009FFF00555F2A000000
      0000000000000000000000000000559FD400555F7F00005FAA00557FAA00557F
      D400559FAA00557FD400559FAA00557FAA00007FAA00007FAA00555FAA00559F
      D400557F5500FF7F7F00AA9F7F00AA7F5500AA5F2A00AA5F5500AA7F5500553F
      5500559FAA00007FAA0055DFD40055BFFF0000DFFF0055BFD400555F55000000
      000000000000000000000000000000000000005F7F00007FAA00005FAA000080
      8000555FAA00007FAA00005FAA00007FAA00555FAA00005FAA00007FAA00AA9F
      AA00555F7F00AA9F5500FF9FAA00AA5F5500AA5F5500AA5F5500AA5F5500555F
      2A00559FD40055BFD40055BFFF0055DFD40055BFFF0000BFD400553F55000000
      000000000000000000000000000000000000003F5500555FAA00005FAA00557F
      AA00005FAA00557FAA00005FAA00555FAA00005FAA00007FAA00005FAA00AABF
      D400555F5500553F5500553F5500555F5500553F5500555F2A00553F5500555F
      5500555F5500553F5500555F2A00553F5500555F5500553F5500555F55000000
      000000000000000000000000000000000000553F5500007FAA00557FAA00005F
      AA00005FAA00005FAA00557FAA00005FAA00557FAA00005FAA00557FAA00559F
      D400555F5500559FFF00559FD400551FD400003FD400553FD400003FAA00553F
      550055BFAA00557F5500559F7F0055BF7F0055BF7F0055BF7F00553F55000000
      000000000000000000000000000000000000005F5500005FAA00001F5500555F
      7F00005FAA00557FAA00005FAA00557FAA00005FAA00557FAA00007FAA00AA9F
      D40080808000007FD400557FD400005FD400553FAA00003FD400553FAA00553F
      5500559F5500559F7F0055BF550055BFAA0055BF7F00557F5500555F55000000
      0000000000000000000000000000005FAA00555F7F00AABFAA00C0DCC000559F
      AA00553F5500005FAA00557FAA00007FAA00557FAA00007FD400557FAA0055BF
      D400555F5500557FD400559FFF00551FAA00003FD400555FD400001FAA00555F
      5500AABFAA00007F550055BFAA0055BFAA0055BF7F0055BF7F00553F55000000
      0000000000000000000000000000559FAA00557FAA00FFFFFF00FFFFFF00FFFF
      FF00555FAA00005F5500005FAA00557FD400007FAA00557FAA00007FAA00AA9F
      D40080808000559FD400007FD400005FD400553FAA00003FD400557FD400553F
      5500559F7F00559F5500559F550055BF7F0055BFAA00559F5500555F55000000
      000000000000000000000000000000000000557FAA0000808000FFFFFF00557F
      D400005F5500557FD400559FAA00559FD400557FD400559FD400559FD40055BF
      D400555F5500559FFF00557FD400551FD400003FD400553FD400553FAA00555F
      5500559F7F00557F550055BF7F0055BF7F0055BFAA0055BF7F00553F55000000
      00000000000000000000000000000000000000000000557FAA00557FAA00003F
      5500559FD400559FD400559FD400559FD400559FD400559FD400559FD400AABF
      D400AA9FAA00555F5500555F5500557F5500555F7F00555F5500555F7F00555F
      5500557F7F00555F7F00555F5500555F5500555F5500555F5500AA9FAA000000
      00000000000000000000000000000000000000000000557FAA00557FAA00559F
      D40055BFD40055BFD40055BFFF0055BFD40055BFFF0055BFD40055BFD40055BF
      D400AADFFF00AABFFF00AADFFF00AABFD400AABFD40055DFD400AABFD400AABF
      FF00A4A0A000AADFD400AA7FAA00555FAA00555FAA0080808000555F7F000000
      0000000000000000000000000000000000000000000000000000559FAA0055BF
      D40055BFD400AADFFF0055DFD40055DFFF00AADFD40055DFFF0055DFD400AADF
      FF0055BFD400AADFFF0055BFD400559FFF00559FD400557FD400559FD400559F
      AA00007FAA00AA9FD400003F7F00000055000000550000005500000055000000
      000000000000000000000000000000000000000000000000000000000000559F
      D40055DFD40055DFFF00AADFFF0055FFFF0055FFFF00AADFFF0055FFFF0055DF
      FF00AAFFFF0055BFD400AADFFF0055BFD400559FD400559FD400559FD400557F
      D400559FAA00559FAA00551F550000007F00000055000000550000002A000000
      000000000000000000000000000000000000000000000000000000000000557F
      AA0055BFD40055BFD40055DFFF0055FFFF00AADFFF0055DFFF00AAFFFF00AADF
      FF0055DFFF00AADFFF0055BFFF00559FD400009FD400559FD400559FD4000080
      8000559FD400AA9FD4000000550000005500000055000000550000002A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000555FAA00559FD400559FD40055BFD40055DFD40055DFFF0055DFD40055DF
      FF0055BFD40055BFD400559FD400559FD400559FD400559FD400557FAA00559F
      D400559FD400555F550000007F0000007F0000007F0000005500000055000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000557FAA00559FAA00559FD400559FD400559FD400559FD400559F
      D400559FD400559FD400559FD400559FD400559FD400557FAA00559FD400559F
      D400557FAA00001F5500001F7F00551F55000000550000007F00000055000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000005FAA00557FAA00557FD400559FD400559FD400559FD400559F
      D400559FD400559FAA00559FD400557FAA00557FD40055BFD40055BFD400559F
      D400553F5500000080000000800000007F000000550000005500553F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000005F7F00559FAA00559FAA00009FAA00557FAA0000808000557FAA00557F
      AA0000808000557FAA00559FD40055BFD40055DFD40055BFD40055BFD400555F
      550055007F00001F7F00551F550000007F0000007F0000007F00003F7F000000
      000000000000000000000000000000000000000000000000000000000000557F
      7F00555F7F00007FD400559FD400559FAA0055BFD40055BFD40055DFFF0055DF
      FF00AADFFF0055FFFF0055DFD400AADFFF0055BFFF0055BFD400555F55005500
      AA00001F55000000800000008000001F7F000000800000005500000000000000
      0000000000000000000000000000000000000000000000000000555F5500553F
      5500003FAA00559FAA00009FAA00559FD40055BFD40055BFFF0055DFD400AADF
      FF0055FFFF0055DFFF00AADFFF0055DFD400559FD400555F5500001F55000000
      AA000000AA00551F55000000AA000000800000008000003F7F00000000000000
      000000000000000000000000000000000000003F7F00003F55000000AA00001F
      D400553F7F00555F7F00553F7F00557FAA00559FAA0055BFD40055DFFF0055DF
      D400AADFFF0055DFD400559FD400555F7F00555F55005500AA000000AA00001F
      5500000080000000AA00001F5500000080005500550000000000000000000000
      0000000000000000000000000000553FAA00003F55000000D4000000D4005500
      D400000080000000D400551FAA00553FAA00553F7F00555F5500555F5500557F
      5500555F5500553F5500553FAA00001FAA000000AA00001F55000000AA000000
      AA000000AA000000AA000000800000008000003F7F0000000000000000000000
      000000000000003F7F00553F55000000AA000000D4000000D4005500D4000000
      80000000D4000000D400000080000000D400000080000000D4000000AA000000
      80000000D40000007F000000AA000000AA000000AA000000AA00551F55000000
      AA000000AA00000080000000AA00003F7F00000000000000000000000000553F
      7F00003F7F000000AA000000D4000000D4000000D4005500FF00000080000000
      D4000000AA000000D400001FAA005500D400000080000000D4000000D4000000
      AA000000AA000000AA000000AA000000AA000000D4000000AA000000AA000000
      80000000AA000000AA0000007F00000000000000000000000000000000000000
      80000000D4000000D400555FD4000000D4005500D400555FAA000000D4000000
      D4000000D400000080005500D4000000D4000000D4000000AA000000D4000000
      D4000000D4000000AA000000AA000000AA000000AA000000AA000000D4000000
      AA0000008000553F7F0000000000000000000000000000000000000000000000
      000000008000AA9FD4000000D4000000D400555FD4000000D4000000D4000000
      D4000000D4000000D4005500D4000000AA000000D4000000AA000000D4000000
      AA000000AA000000D4000000AA000000D4000000AA000000AA000000AA000000
      8000003F7F000000000000000000000000000000000000000000000000000000
      000000000000003F7F000000AA00AA9FD4000000D4000000D400555FD4000000
      D4000000D4000000D4000000AA00555FD4000000D400000080000000D4000000
      D4000000D4000000D4000000AA000000D4000000AA0000007F00003F7F000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000003F7F000000AA00AA9FD4000000D4000000
      D4000000D4000000D400AA9FFF000000AA000000D4000000D4000000D4000000
      AA000000D4000000D40000008000553F7F00003F7F0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000003F7F00000080000000
      80000000AA0000008000555FAA000000AA000000800000008000000080000000
      AA00003F7F00553F7F0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      8000E7FC0000E0000000F0000000F0000000F8000000F8000000F8000000F800
      0000F0000000F0000000F8000000FC000000FC000000FE000000FF000000FF00
      0000FF800000FFC00000FFC00000FF800000FF000001FE000001F8000003F000
      0003C00000070000000F0000001F8000003FC00000FFF00003FFFC001FFF}
    ApplicationShortcuts.Options = [SendTo, StartMenu, StartUp, Desktop, OpenWith, Programs, QuickLaunch, ProgramsSubDir]
    ApplicationShortcuts.MenuSubDir = 'File Extension '
    OnBusyStateChange = FileExtAssociate1BusyStateChange
    OnErrorText = FileExtAssociate1ErrorText
    OnSuccessText = FileExtAssociate1SuccessText
    OnComplete = FileExtAssociate1Complete
    Left = 384
    Top = 376
  end
end
