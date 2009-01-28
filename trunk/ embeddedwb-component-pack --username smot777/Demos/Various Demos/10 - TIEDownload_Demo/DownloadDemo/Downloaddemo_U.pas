//*************************************************************************
//                                                                        *
//                       IEDownload Demo                                  *                                                      *
//                            by                                          *
//                     Per Lindsø Larsen                                  *
//                                                                        *
//  Contributions:                                                        *
//  Eran Bodankin - bsalsa - (bsalsa@bsalsa.com)                          *
//  Updated versions:                                                     *
//               http://www.bsalsa.com                                    *
//*************************************************************************
{LICENSE:
THIS SOFTWARE IS PROVIDED TO YOU "AS IS" WITHOUT WARRANTY OF ANY KIND,
EITHER EXPRESSED OR IMPLIED INCLUDING BUT NOT LIMITED TO THE APPLIED
WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
YOU ASSUME THE ENTIRE RISK AS TO THE ACCURACY AND THE USE OF THE SOFTWARE
AND ALL OTHER RISK ARISING OUT OF THE USE OR PERFORMANCE OF THIS SOFTWARE
AND DOCUMENTATION. [YOUR NAME] DOES NOT WARRANT THAT THE SOFTWARE IS ERROR-FREE
OR WILL OPERATE WITHOUT INTERRUPTION. THE SOFTWARE IS NOT DESIGNED, INTENDED
OR LICENSED FOR USE IN HAZARDOUS ENVIRONMENTS REQUIRING FAIL-SAFE CONTROLS,
INCLUDING WITHOUT LIMITATION, THE DESIGN, CONSTRUCTION, MAINTENANCE OR
OPERATION OF NUCLEAR FACILITIES, AIRCRAFT NAVIGATION OR COMMUNICATION SYSTEMS,
AIR TRAFFIC CONTROL, AND LIFE SUPPORT OR WEAPONS SYSTEMS. VSOFT SPECIFICALLY
DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTY OF FITNESS FOR SUCH PURPOSE.

You may use, change or modify the component under 3 conditions:
1. In your website, add a link to "http://www.bsalsa.com"
2. In your application, add credits to "Embedded Web Browser"
3. Mail me  (bsalsa@bsalsa.com) any code change in the unit
   for the benefit of the other users.
4. Please, consider donation in our web site!
{*******************************************************************************}

unit Downloaddemo_U;

interface

uses
  Windows, SysUtils, Classes, Forms, UrlMon, IEDownload, StdCtrls, Controls,
  ComCtrls, SHDocVw_EWB, EwbCore, EmbeddedWB, IEAddress, ExtCtrls, IEDownloadtools, OleCtrls;

type
  TForm1 = class(TForm)
    IEDownload1: TIEDownload;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Panel2: TPanel;
    btnStart: TButton;
    btnStop: TButton;
    MemoInfo: TMemo;
    MemoPreview: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    EmbeddedWB1: TEmbeddedWB;
    ListView: TListView;
    ProgressBar1: TProgressBar;
    EditURL: TEdit;
    procedure IEDownload1DataAvailable(Sender: TBSCB; var Buffer: PByte;
      var BufLength: Cardinal);
    procedure IEDownload1DownloadComplete(Sender: TBSCB; Stream: TStream;
      Result: HRESULT);
    procedure IEDownload1Progress(Sender: TBSCB; ulProgress, ulProgressMax,
      ulStatusCode: Cardinal; szStatusText: PWideChar; Downloaded, ElapsedTime,
      Speed, RemainingTime, Status: string);
    function IEDownload1BeginningTransaction(Sender: TBSCB; szURL,
      szHeaders: PWideChar; dwReserved: Cardinal;
      out szAdditionalHeaders: PWideChar): HRESULT;
    procedure IEDownload1BusyStateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure IEDownload1ErrorText(Sender: TBSCB; Text: string);
    procedure IEDownload1RespondText(Sender: TBSCB; Text: string);
    procedure IEDownload1StatusText(Sender: TBSCB; Text: string);
    procedure btnStartClick(Sender: TObject);
  private
    { Private declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.btnStartClick(Sender: TObject);
begin
  with StatusBar1 do
  begin
    Panels[0].Text := '';
    Panels[1].Text := '';
    Panels[2].Text := '';
  end;
  IEDownload1.Go(EditURL.Text);
end;

procedure TForm1.btnStopClick(Sender: TObject);
begin
  IEDownload1.Cancel;
end;

procedure TForm1.IEDownload1DataAvailable(Sender: TBSCB; var Buffer: PByte;
  var BufLength: Cardinal);
begin
  MemoPreview.Lines.Add(PChar(Buffer));
end;

procedure TForm1.IEDownload1DownloadComplete(Sender: TBSCB; Stream: TStream;
  Result: HRESULT);
begin
  case IEDownload1.DownloadMethod of
    dlStream:
      begin
        if (Result = S_OK) and (Stream <> nil) then
        begin
          EmbeddedWB1.LoadFromStream(Stream);
          MemoInfo.Lines.Add('Download complete.');

        end
        else
          MemoInfo.Lines.Add(ErrorText(Result) + ' ' + ResponseCodeText(Sender.ResponseCode))
      end
  else
    Application.ProcessMessages;
    EmbeddedWB1.Go(IEDownload1.DownloadedFile);
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  EmbeddedWB1.AssignEmptyDocument;
end;

function TForm1.IEDownload1BeginningTransaction(Sender: TBSCB; szURL,
  szHeaders: PWideChar; dwReserved: Cardinal;
  out szAdditionalHeaders: PWideChar): HRESULT;
begin
  MemoInfo.Lines.Add('Downloading from: ' + IEDownload1.Url);
  Result := S_OK;
end;

procedure TForm1.IEDownload1BusyStateChange(Sender: TObject);
begin
  btnStart.Enabled := not IEDownload1.Busy;
  btnStop.Enabled := not btnStart.Enabled;
end;

procedure TForm1.IEDownload1Progress(Sender: TBSCB; ulProgress, ulProgressMax,
  ulStatusCode: Cardinal; szStatusText: PWideChar; Downloaded, ElapsedTime,
  Speed, RemainingTime, Status: string);
var
  ListItem: TListItem;
  st: string;
begin
  ProgressBar1.Max := ulProgressMax;
  ProgressBar1.Position := ulProgress;
  with ListView do
  begin
    Items.BeginUpdate();
    try
      ListItem := ListView.Items.Add();
      ListItem.Caption := EditURL.Text;
      with ListItem.SubItems do
      begin
        Add(Speed);
        Add(Downloaded);
        Add(RemainingTime);
        Add(ElapsedTime);
        Add(Status);
      end;
    finally
      Items.EndUpdate();
    end;
  end;
  st := BindStatusText(ulStatusCode);
  if ulStatusCode = BINDSTATUS_DOWNLOADINGDATA then
  begin
    st := st + ' (' + IntToStr(ulProgress) + '/' + IntToStr(ulProgressMax) + ')';
    MemoInfo.Lines.Add(st);
  end;
end;

procedure TForm1.IEDownload1StatusText(Sender: TBSCB; Text: string);
begin
  StatusBar1.Panels[0].Text := 'Status: ' + Text;
end;

procedure TForm1.IEDownload1ErrorText(Sender: TBSCB; Text: string);
begin
  StatusBar1.Panels[1].Text := 'Errors: ' + Text;
end;

procedure TForm1.IEDownload1RespondText(Sender: TBSCB; Text: string);
begin
  StatusBar1.Panels[2].Text := 'Respond: ' + Text;
end;

end.

