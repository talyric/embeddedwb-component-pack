//*************************************************************************
//                                                                        *
//                    IEDownload Resume Demo                              *                                                      *
//                            by                                          *
//                     Per Lindsø Larsen                                  *
//                                                                        *
//  Contributions:                                                        *
//  Eran Bodankin -bsalsa(bsalsa@bsalsa.com)                              *
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

unit Resumedemo_U;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, UrlMon, IEDownload,
  IEDownloadTools, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    MemoLog: TMemo;
    IEDownload1: TIEDownload;
    Label1: TLabel;
    ProgressBar1: TProgressBar;
    procedure IEDownload1DownloadComplete(Sender: TBSCB; Stream: TStream;
      Result: HRESULT);
    procedure IEDownload1ErrorText(Sender: TBSCB; Text: string);
    procedure IEDownload1RespondText(Sender: TBSCB; Text: string);
    procedure IEDownload1StatusText(Sender: TBSCB; Text: string);
    procedure IEDownload1Progress(Sender: TBSCB; ulProgress, ulProgressMax,
      ulStatusCode: Cardinal; szStatusText: PWideChar; Downloaded, ElapsedTime,
      Speed, RemainingTime, Status: string);
    procedure Button1Click(Sender: TObject);
    function IEDownload1Response(Sender: TBSCB; dwResponseCode: Cardinal;
      szResponseHeaders, szRequestHeaders: PWideChar;
      out szAdditionalRequestHeaders: PWideChar): HRESULT;
  private
    bFileExist: boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
  if not bFileExist then
  begin
    if Button1.Caption <> 'Pause' then
    begin
      Button1.Caption := 'Pause';
      IEDownload1.go('http://www.bsalsa.com/DP/download.php?file=0');
    end
    else
    begin
      IEDownload1.Cancel;
      Button1.Caption := 'Resume';
    end;
  end;
end;

procedure TForm1.IEDownload1DownloadComplete(Sender: TBSCB; Stream: TStream;
  Result: HRESULT);
begin
  if (Result = S_OK) then
  begin
    MemoLog.Lines.Add('Download complete...');
    Button1.Caption := 'Start Download';
  end
  else if (Result = E_ABORT) and (Sender.ResponseCode = 206) then
    MemoLog.Lines.Add('Cancelled by user...')
  else if (Result = E_ABORT) and (Sender.ResponseCode = 416) then
  begin
    MemoLog.Lines.Add('File already downloaded...');
    bFileExist := True;
    Button1.Caption := 'File already downloaded.';
  end
  else
    MemoLog.Lines.Add(Errortext(Result) + ' ' +
      ResponseCodeText(Sender.ResponseCode));
end;

procedure TForm1.IEDownload1ErrorText(Sender: TBSCB; Text: string);
begin
  MemoLog.Lines.Add(Text);
end;

procedure TForm1.IEDownload1Progress(Sender: TBSCB; ulProgress, ulProgressMax,
  ulStatusCode: Cardinal; szStatusText: PWideChar; Downloaded, ElapsedTime,
  Speed, RemainingTime, Status: string);
var
  s: string;
begin
  Progressbar1.Max := ulProgressMax;
  Progressbar1.Position := ulProgress;
  s := BindstatusText(ulStatusCode);
  if ulStatusCode = BINDSTATUS_DOWNLOADINGDATA then
    s := S + ' (' + InttoStr(ulProgress) + '/' + InttoStr(ulProgressMax) + ')';
  Label1.Caption := 'Estimated time left: ' + RemainingTime;
end;

procedure TForm1.IEDownload1RespondText(Sender: TBSCB; Text: string);
begin
  MemoLog.Lines.Add(Text);
end;

function TForm1.IEDownload1Response(Sender: TBSCB;
  dwResponseCode: Cardinal; szResponseHeaders, szRequestHeaders: PWideChar;
  out szAdditionalRequestHeaders: PWideChar): HRESULT;
begin
  if dwResponseCode = 206 then
    MemoLog.Lines.Add('Resume supported by server...')
  else
    MemoLog.Lines.Add('Resume not supported by server...');
  Result := S_OK;
end;

procedure TForm1.IEDownload1StatusText(Sender: TBSCB; Text: string);
begin
  MemoLog.Lines.Add(Text);
end;

end.

