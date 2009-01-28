unit WBFrameText;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Memo2: TMemo;
    Panel1: TPanel;
    chkoutertext: TRadioButton;
    chkouterhtml: TRadioButton;
    chkinnertext: TRadioButton;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  ActiveX, Shdocvw_tlb, MSHTML, comobj;

type
  TObjectFromLResult = function(LRESULT: lResult; const IID: TIID; WPARAM: wParam; out pObject): HRESULT; stdcall;


function GetIEFromHWND(WHandle: HWND; var IE: IWebbrowser2): HRESULT;
var
  hInst: HWND;
  lRes: Cardinal;
  MSG: Integer;
  pDoc: IHTMLDocument2;
  ObjectFromLresult: TObjectFromLresult;
begin
  hInst := LoadLibrary('Oleacc.dll');
  @ObjectFromLresult := GetProcAddress(hInst, 'ObjectFromLresult');
  if @ObjectFromLresult <> nil then begin
    try
      MSG := RegisterWindowMessage('WM_HTML_GETOBJECT');
      SendMessageTimeOut(WHandle, MSG, 0, 0, SMTO_ABORTIFHUNG, 1000, lRes);
      Result := ObjectFromLresult(lRes, IHTMLDocument2, 0, pDoc);
      if Result = S_OK then
        (pDoc.parentWindow as IServiceprovider).QueryService(IWebbrowserApp, IWebbrowser2, IE);
    finally
      FreeLibrary(hInst);
    end;
  end;
end;

procedure WB_GetDocumentSourceToStream(Document: IDispatch; Stream: TStream);
// Save a TWebbrowser Document to a Stream
var
  PersistStreamInit: IPersistStreamInit;
  StreamAdapter: IStream;
begin
  Assert(Assigned(Document));
  Stream.Size := 0;
  Stream.Position := 0;
  if Document.QueryInterface(IPersistStreamInit,
    PersistStreamInit) = S_OK then
  begin
    StreamAdapter := TStreamAdapter.Create(Stream, soReference);
    PersistStreamInit.Save(StreamAdapter, False);
    StreamAdapter := nil;
  end;
end;

function WB_GetDocumentSourceToString(Document: IDispatch): string;
// Save a Webbrowser Document to a string
var
  Stream: TStringStream;
begin
  Result := '';
  Stream := TStringStream.Create('');
  try
    WB_GetDocumentSourceToStream(Document, Stream);
    Result := StringReplace(Stream.Datastring, #$A#9, #$D#$A, [rfReplaceAll]);
    Result := StringReplace(Result, #$A, #$D#$A, [rfReplaceAll]);
  finally
    Stream.Free;
  end;
end;

function WB_GetPlainText(AHtmlDocument: IHtmlDocument2; s: TStrings): string;
var
  IDoc: IHTMLDocument2;
  Strl: TStringList;
  sHTMLFile: string;
  v: Variant;
begin
  sHTMLFile := WB_GetDocumentSourceToString(AHtmlDocument);
  Strl := TStringList.Create;
  try
    Strl.Add(sHTMLFile);
    Idoc := CreateComObject(Class_HTMLDOcument) as IHTMLDocument2;
    try
      IDoc.designMode := 'on';
      while IDoc.readyState <> 'complete' do
        Application.ProcessMessages;
      v := VarArrayCreate([0, 0], VarVariant);
      v[0] := Strl.Text;
      IDoc.write(PSafeArray(System.TVarData(v).VArray));
      IDoc.designMode := 'off';
      while IDoc.readyState <> 'complete' do
        Application.ProcessMessages;
      s.add(IDoc.body.innerText);
    finally
      IDoc := nil;
    end;
  finally
    Strl.Free;
  end;
end;

type
  TEnumFramesProc = function(AHtmlDocument: IHtmlDocument2; Data: Integer): Boolean;

function EnumFrames(AHtmlDocument: IHtmlDocument2;
  EnumFramesProc: TEnumFramesProc; Data: Integer): Boolean;

  function Enum(AHtmlDocument: IHtmlDocument2): Boolean;
  var
    OleContainer: IOleContainer;
    EnumUnknown: IEnumUnknown;
    Unknown: IUnknown;
    Fetched: LongInt;
    WebBrowser: IWebBrowser;
  begin
    Result := True;
    if not Assigned(AHtmlDocument) then
      Exit;
    Result := EnumFramesProc(AHtmlDocument, Data);
    if not Result then
      Exit;

    if not Supports(AHtmlDocument, IOleContainer, OleContainer) then
      Exit;
    if Failed(OleContainer.EnumObjects(OLECONTF_EMBEDDINGS, EnumUnknown)) then
      Exit;
    while (EnumUnknown.Next(1, Unknown, @Fetched) = S_OK) do
      if Supports(Unknown, IWebBrowser, WebBrowser) then
      begin
        Result := Enum(WebBrowser.Document as IHtmlDocument2);
        if not Result then
          Exit;
      end;
  end;
begin
  Result := Enum(AHtmlDocument);
end;


procedure WB_GetFrames(IE: IWebBrowser2; sl: TMemo);

  function EnumProc(AHtmlDocument: IHtmlDocument2; Data: Integer): Boolean;
  var p, q, i: Integer;
    s, s1, s2, sMSISDN, sBAN, sCName: string;
    sl: TStrings;
  begin
    Result := True;
    Try
    Form1.Memo1.lines.add(AHtmlDocument.url);
    form1.Memo2.Lines.add('*********************************************');
    form1.Memo2.Lines.add(AHtmlDocument.url);
    if form1.chkoutertext.Checked then
    form1.Memo2.Lines.add(AHtmlDocument.body.outertext) else
    if form1.chkouterhtml.Checked then
    form1.Memo2.Lines.add(AHtmlDocument.body.outerhtml) else
    if form1.chkinnertext.Checked then
    form1.Memo2.Lines.add(AHtmlDocument.body.innertext) else
    begin
     sl := TStringList.Create();
    WB_GetPlainText(AHtmlDocument, sl);
    form1.Memo2.Lines.add(sl.Text);
    sl.free;
    end;

    Except
      form1.Memo2.Lines.add('***************Exception******************');
    end;
        form1.Memo2.Lines.add('*********************************************');




   // ShowMessage(AHtmlDocument.url);
   { if Pos('customer/customerSub.htm', AHtmlDocument.url) <> 0 then
    begin
      s := AHtmlDocument.body.outertext;
      p := Pos('MSISDN', s);
      if p <> 0 then
      begin
        sMSISDN := Copy(s, p + 6, 18);
      end;
      p := Pos('BAN', s);
      if p <> 0 then
      begin
        sBAN := Copy(s, p + 3, 12);
      end;
    end;

    if Pos('customer/customerBan.htm', AHtmlDocument.url) <> 0 then
    begin
      s := AHtmlDocument.body.outertext;
      p := Pos('Name', s);
      if p <> 0 then
      begin

        s2 := Copy(s, p + 4, Length(s));
        q := Pos('Amtliche', s);
        if q <> 0 then
        begin
          sCName := Copy(s, p + 4, q - 2);
        end;
      end;
      Result := False;
    end;}
  end;

begin
  EnumFrames(IE.Document as IHtmlDocument2, @EnumProc, Integer(IE));
  // Delete 1. item because it's the mainframe
//  frmMyBrowser.lbFrames.Items.Delete(0);
end;

function FindWindowByTitle(WindowTitle: string): Hwnd;
var
  NextHandle: Hwnd;
  NextTitle: array[0..260] of char;
begin
  // Get the first window
  NextHandle := GetWindow(Application.Handle, GW_HWNDFIRST);
  while NextHandle > 0 do
  begin
    // retrieve its text
    GetWindowText(NextHandle, NextTitle, 255);
    if Pos(WindowTitle, StrPas(NextTitle)) <> 0 then
    begin
      Result := NextHandle;
      Exit;
    end
    else
      // Get the next window
      NextHandle := GetWindow(NextHandle, GW_HWNDNEXT);
  end;
  Result := 0;
end;

// frames: http://www.w3schools.com/HTML/tryit.asp?filename=tryhtml_frame_cols

procedure GetIEWindows(lb: TMemo; var MSISDN, BAN, CName: string);
  function EnumWindowsProc(Wnd: HWND; lb: TMemo): BOOL; stdcall;
  var
    theClassname: array[0..128] of Char;
    WinTitle: array[0..260] of char;
    caption: array[0..128] of Char;
    IE: IWebbrowser2;
    WndChild: HWND;
    bWinTitlesMatch: Boolean;
  begin
    Result := True;
    Windows.GetClassname(Wnd, theClassname, Sizeof(theclassname));

    GetWindowText(Wnd, WinTitle, 255);
    bWinTitlesMatch := Pos(('ICE [ Amdocs ID'),StrPas(WinTitle)) <> 0;
    if paramstr(1) = 'test' then bWinTitlesMatch := True;

    if (theClassname = 'IEFrame') and (bWinTitlesMatch) then
    begin


    wndChild := FindWindowEx(Wnd, 0, 'Frame Tab', nil);
    if WndChild <> 0 then
      WndChild := FindWindowEX(wndChild, 0, 'TabWindowClass', nil) else
      WndChild := FindWindowEX(Wnd, 0, 'TabWindowClass', nil) ;

      if WndChild = 0 then
        WndChild := FindWindowEX(Wnd, 0, 'Shell DocObject View', nil)
      else
        WndChild := FindWindowEX(WndChild, 0, 'Shell DocObject View', nil);

    if wndChild = 0 then
    begin
      wndChild := FindWindowEx(Wnd, 0, 'Shell DocObject View', nil);
    end;
      if WndChild <> 0 then
      begin
        WndChild := FindWindowEX(WndChild, 0, 'Internet Explorer_Server', nil);
        if WndChild <> 0 then
        begin
          Form1.Memo1.lines.add('*Internet Explorer_Server found');
          if GetIEFromHWND(WndChild, IE) = S_OK then
            if IE <> nil then
            begin
              Form1.Memo1.lines.add('*GetIEFromHWND ok');
              WB_GetFrames(IE, lb);
            end;
        end;
      end;
    end;
  end;
begin
  lb.Clear;
  EnumWindows(@EnumWindowsProc, Integer(lb));
end;



procedure TForm1.Button1Click(Sender: TObject);
var
  MSISDN, BAN, CName: string;
begin
  Memo1.Clear;
  Memo2.Clear;
  GetIEWindows(Memo1, MSISDN, BAN, CName);
//  WB_GetFrames(FPrevBrowser, LbFrames.Items);
end;

end.

