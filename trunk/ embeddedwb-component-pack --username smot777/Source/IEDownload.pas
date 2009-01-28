//*************************************************************************
//                                                                        *
//                        IEDownload                                      *
//                       For Delphi                                       *
//                                                                        *
//                     Freeware Component                                 *
//                            by                                          *
//                     Per Lindsø Larsen                                  *
//                     and Eran Bodankin                                  *
//  Developing Team:                                                      *
//  Eran Bodankin -bsalsa(bsalsa@bsalsa.com) (All the new stuf)           *
//  Mathias Walter (mich@matze.tv)  Attachment, callback, and a lot more  *
//                                                                        *
//                                                                        *
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

You may use, change or modify the component under 4 conditions:
1. In your website, add a link to "http://www.bsalsa.com"
2. In your application, add credits to "Embedded Web Browser"
3. Mail me  (bsalsa@bsalsa.com) any code change in the unit
   for the benefit of the other users.
4. Please, consider donation in our web site!
{*******************************************************************************}
//$Id: IEDownload.pas,v 1.5 2006/12/05 11:56:31 bsalsa Exp $

{
TO-DO:
1. Finish QueryInterface(IAuthenticate..)
2. MemLeak?
}

unit IEDownload;

interface

{$I EWB_Compilers.inc}

uses
  IEConst, ActiveX, Contnrs, ExtCtrls, Windows, WinInet, UrlMon,
  Classes, SysUtils;

type

{$IFNDEF UNICODE}
  RawByteString = AnsiString;
{$ENDIF UNICODE}

  TScheme = record
    Name: string;
    Id: Byte;
  end;

  TState = (Requested, Downloading, Canceled, Finished, Error);

type
  INTERNET_PER_CONN_OPTION = record
    dwOption: DWORD;
    Value: record
      case Integer of
        1: (dwValue: DWORD);
        2: (pszValue: PChar); // Unicode/ANSI
        3: (ftValue: TFileTime);
    end;
  end;
  LPINTERNET_PER_CONN_OPTION = ^INTERNET_PER_CONN_OPTION;
  INTERNET_PER_CONN_OPTION_LIST = record
    dwSize: DWORD;
    pszConnection: LPTSTR;
    dwOptionCount: DWORD;
    dwOptionError: DWORD;
    pOptions: LPINTERNET_PER_CONN_OPTION;
  end;
  LPINTERNET_PER_CONN_OPTION_LIST = ^INTERNET_PER_CONN_OPTION_LIST;

const
  EXT_SCHEMES: array[0..5] of TScheme = (
    (Name: 'socks'; Id: INTERNET_SCHEME_SOCKS),
    (Name: 'javascript'; Id: INTERNET_SCHEME_JAVASCRIPT),
    (Name: 'vbscript'; Id: INTERNET_SCHEME_VBSCRIPT),
    (Name: 'res'; Id: INTERNET_SCHEME_RES),
    (Name: 'about'; Id: INTERNET_SCHEME_ABOUT),
    (Name: 'cookie'; Id: INTERNET_SCHEME_COOKIE));

type
  TInfo = record
    AdditionalHeader: TStrings;
    BindInfoValue: Cardinal;
    BindVerbValue: Cardinal;
    CodePageValue: Cardinal;
    CustomVerb: string;
    Descriptor: RawByteString;
    DownloadDir: string;
    ExtraInfo: string;
    FileExt: string;
    FileName: string;
    FileSize: Cardinal;
    Index: Integer;
    InheritHandle: Boolean;
    OpenAfterDownload: Boolean;
    Password: string;
    PostData: string;
    PutFileName: string;
    RangeBegin: Cardinal;
    RangeEnd: Integer;
    Sender: TObject;
    TimeOut: Integer;
    Url: PWideChar;
    UrlEncodeValue: Cardinal;
    UserAgent: string;
    UserName: string;
  end;

  TProxySettings = class(TPersistent)
  private
    FPort: Integer;
    FServer: string;
    FAutoLoadProxy: Boolean;
  public
    function SetProxy(FullUserAgent, ProxyServer: string): Boolean; //mladen
  published
    property AutoLoadProxy: Boolean read FAutoLoadProxy write FAutoLoadProxy
      default False;
    property Port: Integer read FPort write FPort default 80;
    property Server: string read FServer write FServer;
  end;

  TIEDownload = class;

  TBSCB = class(TObject,
      IUnknown, //http://msdn2.microsoft.com/en-us/library/aa909057.aspx
      IBindStatusCallback, //http://msdn.microsoft.com/library/default.asp?Url=/workshop/networking/moniker/reference/ifaces/ibindstatuscallback/ibindstatuscallback.asp
      IHttpNegotiate, //http://msdn.microsoft.com/library/default.asp?Url=/workshop/networking/moniker/reference/ifaces/ihttpnegotiate/ihttpnegotiate.asp
      IAuthenticate, //http://msdn.microsoft.com/library/default.asp?Url=/workshop/networking/moniker/reference/ifaces/iauthenticate/authenticate.asp
      IWindowForBindingUI, //http://msdn.microsoft.com/library/default.asp?Url=/workshop/networking/moniker/reference/ifaces/iwindowforbindingui/iwindowforbindingui.asp
      IHTTPSecurity) //http://msdn.microsoft.com/library/default.asp?Url=/workshop/networking/moniker/reference/ifaces/ihttpsecurity/ihttpsecurity.asp

  private
    FBindCtx: IBindCtx;
    FBSCBTimer: TTimer;
    FDataAvailable: Integer;
    FDataSize: Integer;
    FGlobalData: HGLOBAL;
    FMoniker: IMoniker;
    FRedirect: Boolean;
    FSender: TIEDownload;
    FStartTime, FInitializeTime: TDatetime;
    FStream: IStream;
    FTimedOut: Boolean;
    FTotalRead: Cardinal;
    m_pPrevBSCB: IBindStatusCallback;
    OutputFile: TFileStream;
    StartTick: Int64;
{$IFDEF DELPHI_7_UP}
    FormatSettings: TFormatSettings;
{$ENDIF}
    FState: TState;

    {IBindStatusCallback Interface}
    function GetBindInfo(out grfBINDF: DWORD; var BindInfo: TBindInfo): HRESULT;
      stdcall;
    function GetPriority(out nPriority): HRESULT; stdcall;
    function OnDataAvailable(grfBSCF: DWORD; dwSize: DWORD; formatetc:
      PFormatEtc;
      stgmed: PStgMedium): HRESULT; stdcall;
    function OnLowResource(Reserved: DWORD): HRESULT; stdcall;
    function OnProgress(ulProgress, ulProgressMax, ulStatusCode: ULONG;
      szStatusText: LPCWSTR): HRESULT; stdcall;
    function OnObjectAvailable(const IID: TGUID; punk: IUnknown): HRESULT;
      stdcall;
    function OnStartBinding(dwReserved: DWORD; pib: IBinding): HRESULT; stdcall;
    function OnStopBinding(HRESULT: HRESULT; szError: LPCWSTR): HRESULT;
      stdcall;
    {IHTTPNegotiate methods}
    function OnResponse(dwResponseCode: DWORD; szResponseHeaders,
      szRequestHeaders: LPCWSTR;
      out szAdditionalRequestHeaders: LPWSTR): HRESULT; stdcall;
    function BeginningTransaction(szURL, szHeaders: LPCWSTR; dwReserved: DWORD;
      out szAdditionalHeaders: LPWSTR): HRESULT; stdcall;
    {IAuthenticate Interface}
    function Authenticate(var hwnd: HWnd; var szUserName, szPassword: LPWSTR):
      HRESULT; stdcall;
    {IHttpSecurity Interface}
    function OnSecurityProblem(dwProblem: DWORD): HRESULT; stdcall;
    {IUnknown Interface}
    function QueryInterface(const IID: TGUID; out Obj): HRESULT; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    {IWindowForBindingUI methods}
    function GetWindow(const GUIDReason: TGUID; out hwnd): HRESULT; stdcall;

    function CheckCancelState: Integer;
    function Download: HRESULT;
    function DownloadCtx: HRESULT;
    function GetContentDispFilename(): HRESULT;
    function GetFileNameFromUrl(Url: WideString): WideString;
    procedure ClearAll;
    procedure Initialize;
    procedure SetFileName(FileName: string);
    procedure TimerExpired(Sender: TObject);
    procedure UpdateEvents(Code: Integer; BusyState: Boolean; Sender: TBSCB;
      ulProgress, ulProgressMax: ULONG; szStatusText: LPCWSTR; Downloaded,
      ElapsedTime,
      Speed, RemainingTime, Status: string; Stream: TStream);

  public
    Binding: IBinding;
    Info: TInfo;
    ResponseCode: Cardinal;
    Stream: TStream;
    Url: PWideChar;
    UrlFileName: WideString;
    constructor Create(DownloadInfo: TInfo); overload;
    constructor Create(DownloadInfo: TInfo; pmk: IMoniker; pbc: IBindCtx);
      overload;
    destructor Destroy; override;
    function GetBindResult(out clsidProtocol: TCLSID; out dwResult: DWORD;
      out szResult: POLEStr): HRESULT;
    function GetSaveFileAs: WideString;
    function QueryInfo(dwOption: DWORD; var Info: Cardinal): Boolean; overload;
    function QueryInfo(dwOption: DWORD; var Info: string): Boolean; overload;
    function QueryInfo(dwOption: DWORD; var Info: TDateTime): Boolean; overload;
  public
    property FileName: string read Info.FileName write SetFileName;
    property State: TState read FState;
  end;

  TBSCBList = class(TObjectList) // by Jury Gerasimov
  private
    function GetItem(Index: Integer): TBSCB;
    procedure SetItem(Index: Integer; Value: TBSCB);
  public
    property Items[Index: Integer]: TBSCB read GetItem write SetItem; default;
    function byURL(Url: string): TBSCB;
  end;

  TSecurity = class(TPersistent)
  private
    FInheritHandle: Boolean;
    FDescriptor: RawByteString;
  published
    property InheritHandle: boolean read FInheritHandle write FInheritHandle
      default False;
    property Descriptor: RawByteString read FDescriptor write FDescriptor;
  end;

  TRange = class(TPersistent)
  private
    FRangeBegin: Integer;
    FRangeEnd: Integer;
  published
    property RangeBegin: Integer read FRangeBegin write FRangeBegin default 0;
    property RangeEnd: Integer read FRangeEnd write FRangeEnd default 0;
  end;

  TBeginningTransactionEvent = function(Sender: TBSCB; szURL, szHeaders:
    LPCWSTR; dwReserved: DWORD;
    out szAdditionalHeaders: LPWSTR): HRESULT of object;
  TOnResponseEvent = function(Sender: TBSCB; dwResponseCode: DWORD;
    szResponseHeaders, szRequestHeaders: LPCWSTR;
    out szAdditionalRequestHeaders: LPWSTR): HRESULT of object;
  TAuthenticateEvent = function(Sender: TBSCB; var hwnd: HWnd; var szUserName,
    szPassword: LPWSTR): HRESULT of object;
  TOnSecurityProblemEvent = function(Sender: TBSCB; dwProblem: DWORD): HRESULT
    of
    object;
  TOnProgressEvent = procedure(Sender: TBSCB; ulProgress, ulProgressMax,
    ulStatusCode: ULONG;
    szStatusText: LPCWSTR; Downloaded, ElapsedTime, Speed, RemainingTime,
    Status: string) of object;
  TOnDataAvailableEvent = procedure(Sender: TBSCB; var Buffer: PByte; var
    BufLength: Cardinal) of object;
  TOnDownloadCompleteEvent = procedure(Sender: TBSCB; Stream: TStream; Result:
    HRESULT) of object;
  TOnResumeEvent = procedure(Sender: TBSCB; FileName: string; var Action: DWORD)
    of object;
  TGetWindowEvent = function(Sender: TBSCB; const GUIDReason: TGUID; out hwnd:
    LongWord): HRESULT of object;
  TOnBindingEvent = procedure(var Sender: TBSCB; var Cancel: Boolean) of object;
  TOnErrorTextEvent = procedure(Sender: TBSCB; Text: string) of object;
  TOnStatusTextEvent = procedure(Sender: TBSCB; Text: string) of object;
  TOnRespondTextEvent = procedure(Sender: TBSCB; Text: string) of object;

  TBindInfoOption = (
    Asynchronous, AsyncStorage, NoProgressiveRendering, OfflineOperation,
    GetNewestVersion,
    NoWriteCache, NeedFile, PullData, IgnoreSecurityProblem, Resynchronize,
    Hyperlink,
    No_UI, SilentOperation, Pragma_No_Cache, GetClassObject, Reserved_1,
    Free_Threaded,
    Direct_Read, Forms_Submit, GetFromCache_If_Net_Fail, FromUrlmon, Fwd_Back,
    Reserved_2,
    Reserved_3);

  TBindInfoOptions = set of TBindInfoOption;

  TCodePageOption = (
    Ansi, // default to ANSI code page
    OEM, // // default to OEM  code page
    Mac, // default to MAC  code page
    ThreadsAnsi, // Current thread's ANSI code page
    Symbol, // Symbol code page (42)
    UTF7, // Translate using UTF-7
    UTF8); // Translate using UTF-8

  TUrlEncodeOption = (PostData, ExtraInfo);
  TUrlEncodeOptions = set of TUrlEncodeOption;
  TBindVerbOption = (Get, Post, Put, Custom);
  TDownloadMethod = (dlStream, dlFile, dlBoth);
  TFileExistsOption = (feOverwrite, feCancel);

  TIEDownload = class(TComponent)
  private
    FAdditionalHeader: TStrings;
    FBeginningTransaction: TBeginningTransactionEvent;
    FBindInfoOptions: TBindInfoOptions;
    FBindInfoValue: Cardinal;
    FBindVerbOption: TBindVerbOption;
    FBindVerbValue: Cardinal;
    FBusy: Boolean;
    FCancel: Boolean;
    FCodePageOption: TCodePageOption;
    FCodePageValue: Cardinal;
    FCustomVerb: string;
    FDefaultProtocol: string;
    FDefaultUrlFileName: string;
    FDownloadDir: string;
    FDownloadedFile: string;
    FDownloadMethod: TDownloadMethod;
    FExtraInfo: string;
    FFileExistsOption: TFileExistsOption;
    FGetWindow: TGetWindowEvent;
    FObjList: TObjectList;
    FOnAuthenticate: TAuthenticateEvent;
    FOnBinding: TOnBindingEvent;
    FOnBusy: TNotifyEvent;
    FOnDataAvailable: TOnDataAvailableEvent;
    FOnDownloadComplete: TOnDownloadCompleteEvent;
    FOnErrorText: TOnErrorTextEvent;
    FOnProgress: TOnProgressEvent;
    FOnRespondText: TOnRespondTextEvent;
    FOnResponse: TOnResponseEvent;
    FOnResume: TOnResumeEvent;
    FOnSecurityProblem: TOnSecurityProblemEvent;
    FOnStatusText: TOnStatusTextEvent;
    FPassword: string;
    FPostData: string;
    FProxySettings: TProxySettings;
    FPutFileName: string;
    FRange: TRange;
    FRefCount: Integer;
    FSecurity: TSecurity;
    FTimeOut: Integer;
    FullUserAgent: string;
    FUrl: WideString;
    FUrlEncodeOptions: TUrlEncodeOptions;
    FUrlEncodeValue: Cardinal;
    FUserAgent: string;
    FUserName: string;
    function SetHostName: WideString;
    function SetDownloadDir: Boolean;
    procedure SetAdditionalHeader(const Value: Tstrings);
    procedure SetUserAgent;
  protected
    procedure BusyStateChange; dynamic;
    procedure FillInfo(var Info: TInfo);
    procedure SetBindInfoOptions(const Value: TBindInfoOptions);
    procedure SetBindVerbOption(const Value: TBindVerbOption);
    procedure SetCodePageOption(const Value: TCodePageOption);
    procedure SetDefaultProtocol(const Value: string);
    procedure SetDownloadMethod(const Value: TDownloadMethod);
    procedure SetUrlEncodeOptions(const Value: TUrlEncodeOptions);
    procedure UpdateBindInfoValue;
    procedure UpdateUrlEncodeValue;
  public
    Items: TBSCBList;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    //function Go(Url: WideString): TBSCB; overload;
    function Go(Url: Widestring; FileName: WideString): TBSCB; overload;
    procedure Go(Url: WideString); overload;
    procedure Cancel; overload;
    procedure Cancel(Item: TBSCB); overload;
    procedure Download(
      pmk: IMoniker; // Identifies the object to be downloaded
      pbc: IBindCtx); // Stores information used by the moniker to bind
    procedure Loaded; override;
  public
    property Busy: Boolean read FBusy write FBusy default False;
    property DownloadedFile: string read FDownloadedFile write FDownloadedFile;
  published
    property AdditionalHeader: Tstrings read FAdditionalHeader write
      SetAdditionalHeader;
    property CodePage: TCodePageOption read FCodePageOption write
      SetCodePageOption default Ansi;
    property CustomVerb: string read FCustomVerb write FCustomVerb;
    property DefaultProtocol: string read FDefaultProtocol write
      SetDefaultProtocol;
    property DefaultUrlFileName: string read FDefaultUrlFileName write
      FDefaultUrlFileName;
    property DownloadDir: string read FDownloadDir write FDownloadDir;
    property DownloadMethod: TDownloadMethod read FDownloadMethod write
      SetDownloadMethod default dlStream;
    property ExtraInfo: string read FExtraInfo write FExtraInfo;
    property FileExistsOption: TFileExistsOption read FFileExistsOption write
      FFileExistsOption default feOverwrite;
    property Method: TBindVerbOption read FBindVerbOption write SetBindVerbOption
      default Get;
    property OnAuthenticate: TAuthenticateEvent read FOnAuthenticate write
      FOnAuthenticate;
    property OnBeginningTransaction: TBeginningTransactionEvent read
      FBeginningTransaction write FBeginningTransaction;
    property OnBinding: TOnBindingEvent read FOnBinding write FOnBinding;
    property OnBusyStateChange: TNotifyEvent read FOnBusy write FOnBusy;
    property OnDataAvailable: TOnDataAvailableEvent read FOnDataAvailable write
      FOnDataAvailable;
    property OnDownloadComplete: TOnDownloadCompleteEvent read
      FOnDownloadComplete write FOnDownloadComplete;
    property OnErrorText: TOnErrorTextEvent read FOnErrorText write
      FOnErrorText;
    property OnGetWindow: TGetWindowEvent read FGetWindow write FGetWindow;
    property OnProgress: TOnProgressEvent read FOnProgress write FOnProgress;
    property OnRespondText: TOnRespondTextEvent read FOnRespondText write
      FOnRespondText;
    property OnResponse: TOnResponseEvent read FOnResponse write FOnResponse;
    property OnResume: TOnResumeEvent read FOnResume write FOnResume;
    property OnSecurityProblem: TOnSecurityProblemEvent read FOnSecurityProblem
      write FOnSecurityProblem;
    property OnStatusText: TOnStatusTextEvent read FOnStatusText write
      FOnStatusText;
    property Options: TBindInfoOptions read FBindInfoOptions write
      SetBindInfoOptions default
      [Asynchronous, AsyncStorage, PullData, NoWriteCache, GetNewestVersion];
    property Password: string read FPassword write FPassword;
    property PostData: string read FPostData write FPostData;
    property ProxySettings: TProxySettings read FProxySettings write
      FProxySettings;
    property PutFileName: string read FPutFileName write FPutFileName;
    property Range: TRange read FRange write FRange;
    property Security: TSecurity read FSecurity write FSecurity;
    property TimeOut: Integer read FTimeOut write FTimeOut default 0;
    property Url: WideString read FUrl write FUrl;
    property UrlEncode: TUrlEncodeOptions read FUrlEncodeOptions write
      FUrlEncodeOptions default [];
    property UserAgent: string read FUserAgent write FUserAgent;
    property UserName: string read FUserName write FUserName;
  end;

implementation

uses
  EwbCoreTools, EwbUrl, IEDownloadTools, Registry, Forms{$IFDEF DELPHI_6_UP},
  StrUtils{$ENDIF};

function CreateURLMonikerEx(MkCtx: IMoniker; szURL: LPCWSTR;
  out mk: IMoniker; dwFlags: DWORD): HRESULT; stdcall; external UrlMonLib;

{IHttpSecurity Interface}

function TBSCB.OnSecurityProblem(dwProblem: DWORD): HRESULT;
begin
  UpdateEvents(dwProblem, False, Self, 0, 0, 'Security Problem.',
    '0', '0', '0', '0', 'Security Problem.', nil);
  if Assigned(FSender.FOnSecurityProblem) then
  begin
    Result := FSender.FOnSecurityProblem(Self, dwProblem);
  end
  else
    Result := S_OK;
end;

{IAuthenticate Interface}

function TBSCB.Authenticate(var hwnd: HWnd; var szUserName, szPassword: LPWSTR):
  HRESULT;
begin
  if Assigned(FSender.OnAuthenticate) then
    Result := FSender.OnAuthenticate(Self, hwnd, szUserName, szPassword)
  else
    Result := S_OK;
  if szUserName <> '' then
    szUserName := WidestringToLPOLESTR(szUserName)
  else
    szUserName := nil;
  if szPassword <> '' then
    szPassword := WidestringToLPOLESTR(szPassword)
  else
    szPassword := nil;
  if Result <> S_OK then
  begin
    UpdateEvents(Result, False, Self, 0, 0, 'Authenticate problem',
      '0', '0', '0', '0', ErrorText(Result), nil);
  end;
end;

{IHttpNegotiate Interface}

function TBSCB.BeginningTransaction(szURL, szHeaders: LPCWSTR; dwReserved:
  DWORD;
  out szAdditionalHeaders: LPWSTR): HRESULT;
var
  sr: TSearchRec;
  Action: Cardinal;
  S: string;
  Size: Longint;
  x, Len: Integer;
begin
  if CheckCancelState = E_Abort then
  begin
    Result := E_Abort;
    Exit;
  end;
  S := FSender.FullUserAgent + #13 + #10;
  if (Info.FileName <> '') then
  begin
    if FindFirst(Info.FileName, faAnyFile, sr) = 0 then
      //TODO: does the FileName contains the directory???
    begin
      Size := sr.Size;
      FindClose(sr);
      Info.RangeEnd := 0;
      Action := 0;
      if Assigned(FSender.OnResume) then
        FSender.OnResume(Self, Info.FileName, Action);
      case FSender.FFileExistsOption of
        feOverwrite: Action := RESUME_RESPONSE_OVERWRITE;
        feCancel: Action := RESUME_RESPONSE_CANCEL;
      end;
      case Action of
        RESUME_RESPONSE_CANCEL:
          begin
            Result := E_ABORT;
            Exit;
          end;
        RESUME_RESPONSE_OVERWRITE: Info.RangeBegin := 0;
      else
        Info.RangeBegin := Size;
      end;
    end
    else
    begin
      Info.RangeBegin := 0;
      Info.RangeEnd := 0;
    end;
  end;
  if ((Info.RangeBegin <> 0) or (Info.RangeEnd <> 0)) then
  begin
    S := S + 'Range: bytes=' + IntToStr(Info.RangeBegin) + '-';
    if Info.RangeEnd <> 0 then
      S := S + IntToStr(Info.RangeEnd) + #13#10
    else
      S := S + #13#10;
  end;
  if (Info.AdditionalHeader.Text <> '') then
    for x := 0 to Info.AdditionalHeader.Count - 1 do
      S := S + Info.AdditionalHeader[x] + #13#10;
  Len := Length(S);
  szAdditionalHeaders := CoTaskMemAlloc((Len + 1) * sizeof(WideChar));
  StringToWideChar(S, szAdditionalHeaders, Len + 1);
  if Assigned(FSender.FBeginningTransaction) then
    Result := FSender.FBeginningTransaction(Self, szURL, szHeaders, dwReserved,
      szAdditionalHeaders)
  else
    Result := S_OK;
  FBSCBTimer.Enabled := True;
  FTimedOut := False;
end;

function TBSCB.OnResponse(dwResponseCode: DWORD; szResponseHeaders,
  szRequestHeaders: LPCWSTR; out szAdditionalRequestHeaders: LPWSTR): HRESULT;
var
  Len: Cardinal;
  S: string;
  Dest: WideString;
begin
  if CheckCancelState = E_Abort then
  begin
    Result := E_Abort;
    //OnStopBinding will called automatically, so no Binding.Abort is necessary
    Exit;
  end;
  FSender.SetDownloadDir;
  case FSender.FDownloadMethod of
    dlStream: Dest := '';
    dlFile: Dest := FSender.FDownloadDir;
    dlBoth: Dest := FSender.FDownloadDir;
  end;
  ResponseCode := dwResponseCode;
  if (ResponseCode >= 300) then
    UpdateEvents(ResponseCode, False, Self, 0, 0, 'Error.',
      '0', '0', '0', '0', 'Error.', nil);

  if (QueryInfo(HTTP_QUERY_CUSTOM, Len) and (Len = 0)) or
    (QueryInfo(HTTP_QUERY_CONTENT_LENGTH, Len) and (Len = 0)) then
  begin
    Result := E_ABORT;
    UpdateEvents(Result, False, Self, 0, 0, 'File Size Error.',
      '0', '0', '0', '0', 'File Size Error.', nil);
  end
  else if (ResponseCode >= 400) and (ResponseCode < 500) then
  begin
    Result := E_ABORT;
    UpdateEvents(Result, False, Self, 0, 0, 'Aborted.',
      '0', '0', '0', '0', ResponseCodeText(ResponseCode), nil);
  end
  else
  begin
    if Assigned(FSender.FOnResponse) then
      Result := FSender.FOnResponse(self, dwResponseCode,
        szResponseHeaders, szRequestHeaders, szAdditionalRequestHeaders)
    else
      Result := S_OK;
    if (Info.RangeBegin <> 0) and (Info.FileName <> '') then
    begin
      QueryInfo(HTTP_QUERY_ACCEPT_RANGES, S);
      if (S = 'bytes') or (dwResponseCode = 206) then //'Partial Content'
      begin
        OutputFile := TFileStream.Create(GetSaveFileAs(), fmOpenReadWrite);
        OutputFile.Seek(0, soFromEnd);
      end
      else
      begin
        OutputFile := TFileStream.Create(GetSaveFileAs(), fmCreate);
        Info.RangeBegin := 0;
      end;
    end
    else
    begin
      if Info.FileName <> '' then
        OutputFile := TFileStream.Create(GetSaveFileAs(), fmCreate);
    end
  end;
  //{ if Assigned(OutputFile) then
  begin
    OutputFile.Free;
    OutputFile := nil;
  end; //}
end;

{IBindStatusCallback Interface}

function TBSCB.GetBindInfo(out grfBINDF: DWORD; var BindInfo: TBindInfo):
  HRESULT;
var
  Authent: IAuthenticate;
  PutFile: TFileStream;
  Len: Integer;
begin
  grfBINDF := Info.BindInfoValue;
  with BindInfo do
  begin
    cbSize := sizeof(TBINDINFO);
    if FRedirect then
      dwBindVerb := BINDVERB_GET
    else
      dwBindVerb := Info.BindVerbValue;
    grfBindInfoF := Info.UrlEncodeValue;
    //I don't think it is supported by Urlmon.dll yet
    dwCodePage := Info.CodePageValue;

    if (SUCCEEDED(QueryInterface(IAuthenticate, Authent))) then
      if Assigned(Authent) then
      begin
        if Assigned(FSender.OnAuthenticate) then
          //     FSender.OnAuthenticate(Self, hwnd, szUserName, szPassword);
      end;

    with SecurityAttributes do
    begin
      nLength := SizeOf(TSecurityAttributes);
      bInheritHandle := Info.InheritHandle;
      if Info.Descriptor <> '' then
        lpSecurityDescriptor := PAnsiChar(Info.Descriptor)
      else
        lpSecurityDescriptor := nil;
    end;

    if Info.ExtraInfo <> '' then
    begin
      Len := Length(Info.ExtraInfo);
      szExtraInfo := CoTaskMemAlloc((Len + 1) * SizeOf(WideChar));
      StringToWideChar(Info.ExtraInfo, szExtraInfo, Len + 1);
      //szExtraInfo := CoTaskMemAlloc(Len * 2);
      //MultiByteToWideChar(0, 0, Pointer(Info.ExtraInfo), Len, szExtraInfo, Len);
    end
    else
      szExtraInfo := nil;

    case Info.BindVerbValue of
      BINDVERB_PUT:
        if Info.PutFileName <> '' then
        begin
          PutFile := TFileStream.Create(Info.PutFileName, fmOpenRead);
          try
            PutFile.Seek(0, 0);
            FGlobalData := GlobalAlloc(GPTR, PutFile.Size);
            FDataSize := PutFile.Size;
            PutFile.ReadBuffer(Pointer(FGlobalData)^, PutFile.Size);
          finally
            PutFile.Free;
          end;
        end;

      BINDVERB_POST:
        if Info.PostData <> '' then
        begin
          FGlobalData := GlobalAlloc(GPTR, Length(Info.PostData) + 1);
          FDataSize := Length(Info.PostData) + 1;
          Move(Info.PostData[1], Pointer(FGlobalData)^, Length(Info.PostData));
        end;

      BINDVERB_CUSTOM:
        if (Info.CustomVerb <> '') then
        begin
          Len := Length(Info.CustomVerb);
          szCustomVerb := CoTaskMemAlloc((Len + 1) * sizeof(WideChar));
          StringToWideChar(Info.CustomVerb, szCustomVerb, Len + 1);
          //szCustomVerb := CoTaskMemAlloc(Len * 2);
          //MultiByteToWideChar(0, 0, Pointer(Info.CustomVerb), Len, szCustomVerb, Len);
        end
        else
          szCustomVerb := nil;
    end;

    Fillchar(stgmedData, 0, sizeof(STGMEDIUM));
    cbStgmedData := FDataSize;
    with StgmedData do
    begin
      if dwBindVerb = BINDVERB_GET then
        Tymed := TYMED_NULL
      else
        Tymed := TYMED_HGLOBAL;
      // this is the only medium urlmon supports right now
      hGlobal := FGlobalData;
      IUnknown(unkForRelease) := Self;
    end;
  end;
  Result := S_OK;
end;

function TBSCB.GetPriority(out nPriority): HRESULT;
begin
  Result := CheckCancelState;
end;

function TBSCB.OnDataAvailable(grfBSCF, dwSize: DWORD; formatetc: PFormatEtc;
  stgmed: PStgMedium): HRESULT;
var
  Data: PByte;
  BufL, dwRead, dwActuallyRead: Cardinal;
begin
  if FStartTime = 0 then
    FStartTime := Now;
  if CheckCancelState = E_Abort then
  begin
    Result := E_Abort;
    Exit;
  end
  else
  begin
    if Assigned(FBSCBTimer) then
    begin
      FBSCBTimer.Enabled := False;
      FBSCBTimer.Enabled := True;
    end;
    if (grfBSCF = grfBSCF or BSCF_FIRSTDATANOTIFICATION) then
    begin
      if (FStream = nil) and (stgmed.tymed = TYMED_ISTREAM) then
        FStream := IStream(stgmed.stm);
      if Assigned(m_pPrevBSCB) and not Assigned(OutputFile) and (Info.FileName
        <>
        '') then
      try
        //TODO: check for resume
        OutputFile := TFileStream.Create(GetSaveFileAs(), fmCreate);
        Info.RangeBegin := 0;
      except on EFCreateError do
        begin
          Binding.Abort;
          Result := E_FAIL;
          Exit;
          OutputFile.Free;
        end;
      end;
    end;
    dwRead := dwSize - FTotalRead;
    dwActuallyRead := 0;
    if (dwRead > 0) then
      repeat
        Data := AllocMem(dwRead + 1);
        FStream.Read(Data, dwRead, @dwActuallyRead);
        BufL := dwActuallyRead;
        if Assigned(FSender.FOnDataAvailable) then
        begin
          FSender.FOnDataAvailable(self, Data, BufL);
        end;
        if (Info.FileName <> '') and Assigned(OutputFile) then
        begin
          OutputFile.WriteBuffer(Data^, BufL);
        end
        else if Assigned(Stream) then
          Stream.WriteBuffer(Data^, BufL);
        Inc(FTotalRead, dwActuallyRead);
        FreeMem(Data);
      until dwActuallyRead = 0;
  end;
  Result := S_OK;
end;

function TBSCB.OnLowResource(Reserved: DWORD): HRESULT;
begin
  Result := S_OK;
end;

function TBSCB.OnObjectAvailable(const IID: TGUID;
  punk: IUnknown): HRESULT;
begin
  Result := S_OK;
end;

function TBSCB.OnProgress(ulProgress, ulProgressMax, ulStatusCode: ULONG;
  szStatusText: LPCWSTR): HRESULT;
var
  Speed, Elapsed, Downloaded, RemainingTime, Status: string;
  _Speed: Single;
  currentTime: TDateTime;
begin
  if ulProgressMax = 0 then
    ulProgressMax := ulProgress * 100;
  // dummy value in case file size is unknown
  if CheckCancelState = E_Abort then
  begin
    Result := E_Abort;
    Exit;
  end
  else
  begin
    if (Assigned(FSender.FOnStatusText)) and (BindStatusText(ulStatusCode) <>
      'Bindstatus Unknown') then
      FSender.FOnStatusText(Self, BindStatusText(ulStatusCode));
    Status := BindStatusText(ulStatusCode);
    currentTime := Now;
    Elapsed := TimeToStr(currentTime - FInitializeTime{$IFDEF DELPHI_7_UP},
      FormatSettings{$ENDIF});
    if Assigned(m_pPrevBSCB) then
    begin
      //Need to do this otherwise a filedownload dlg will be displayed
      //as we are downloading the file.
      if (ulStatusCode = BINDSTATUS_CONTENTDISPOSITIONATTACH) then
      begin
        Result := S_OK;
        Exit;
      end;
      m_pPrevBSCB.OnProgress(ulProgress, ulProgressMax, ulStatusCode,
        szStatusText);
    end;

    case ulStatusCode of
      BINDSTATUS_ENDDOWNLOADDATA:
        begin
          // FSender.SaveFileAs := Info.FileName;
          Downloaded := 'Done.';
          ulProgress := ulProgressMax;
          Speed := '0/00  kb/sec';
          RemainingTime := '00.00.00';
          Status := 'Done.';
        end;
      BINDSTATUS_DOWNLOADINGDATA:
        if Assigned(FSender.FOnProgress) then
        begin
          try
            if ((currentTime - FStartTime) > 0) and (ulProgress >
              Info.RangeBegin)
              and (ulProgress > 0) and (currentTime > FStartTime) then
              _Speed := (ulProgress - Info.RangeBegin) /
                ((currentTime - FStartTime) * SecsPerDay * MSecsPerSec)
            else
              _Speed := 0;

            Speed := Format('%.1f kb/sec', [_Speed]{$IFDEF DELPHI_7_UP},
              FormatSettings{$ENDIF});
            if (ulProgressMax > 0) and ((_Speed) > 0) and (ulProgressMax >
              ulProgress) then
              RemainingTime := TimeToStr((ulProgressMax - ulProgress) /
                (_Speed * 1000 * SecsPerDay){$IFDEF DELPHI_7_UP},
                FormatSettings{$ENDIF})
            else
              RemainingTime := TimeToStr(0{$IFDEF DELPHI_7_UP},
                FormatSettings{$ENDIF});
            Downloaded := FormatSize(ulProgress + Info.RangeBegin);
          except
            on EZeroDivide do
              RemainingTime := TimeToStr(0{$IFDEF DELPHI_7_UP},
                FormatSettings{$ENDIF});
          end;
        end;
      BINDSTATUS_REDIRECTING:
        begin
          FRedirect := (ulStatusCode = BINDSTATUS_REDIRECTING);
          if (Assigned(FSender.FOnStatusText)) then
            FSender.FOnStatusText(Self, BindStatusText(ulStatusCode));
        end
    else
      ;
    end;
    if Assigned(FSender.FOnProgress) then
      FSender.FOnProgress(Self, ulProgress + Info.RangeBegin, ulProgressMax +
        Info.RangeBegin, ulStatusCode, szStatusText,
        Downloaded, Elapsed, Speed, RemainingTime, Status);
  end;
  Result := S_OK;
end;

function TBSCB.OnStartBinding(dwReserved: DWORD; pib: IBinding): HRESULT;
var
  Cancel: Boolean;
begin
  if CheckCancelState = E_Abort then
    Result := E_FAIL
  else
  begin
    Binding := pib;
    Binding._AddRef;
    QueryInfo(HTTP_QUERY_CONTENT_LENGTH, Info.FileSize);
    GetContentDispFilename();
    if Assigned(m_pPrevBSCB) then
      m_pPrevBSCB.OnStopBinding(HTTP_STATUS_OK, nil);

    case FSender.FDownloadMethod of
      dlStream: FileName := '';
      dlFile, dlBoth:
        begin
          if FileName = '' then
            FileName := GetFileNameFromUrl(Url);
        end;
    end;

    if Assigned(FSender.FOnBinding) then
    begin
      Cancel := False;
      FSender.FOnBinding(Self, Cancel);
      if Cancel then
        Result := E_FAIL
      else
        Result := S_OK;
    end
    else
    begin
      FState := Downloading;
      Result := S_OK;
    end;
  end;
end;

function TBSCB.OnStopBinding(HRESULT: HRESULT; szError: LPCWSTR): HRESULT;
var
  clsidProtocol: TCLSID;
  dwResult: DWORD;
  szResult: POLEStr;
begin
  Result := S_OK;
  if (Assigned(m_pPrevBSCB) and Assigned(FBindCtx)) then
  begin
    //Register PrevBSCB and release our pointers
    FBindCtx.RegisterObjectParam('_BSCB_Holder_', m_pPrevBSCB);
    m_pPrevBSCB._Release();
    m_pPrevBSCB := nil;
    FBindCtx._Release();
    FBindCtx := nil;
    //Decrease our ref count, so when release is called
    //we delete this object
    dec(FSender.FRefCount);
  end;
  if (GetBindResult(clsidProtocol, dwResult, szResult) = S_OK) then
  begin
  end;
  if FTimedOut then
    HRESULT := INET_E_CONNECTION_TIMEOUT;
  if HRESULT = S_OK then
  begin
    FState := Finished;
    if (Info.FileName = '') then
      UpdateEvents(HRESULT, False, Self, 0, 0, 'Ready',
        '', '', '', '', 'Finished', Stream)
    else
    begin
      //   OutputFile.Seek(0, 0);
      UpdateEvents(HRESULT, False, Self, 0, 0, 'Ready',
        '', '', '', '', 'Finished', OutputFile);
    end;
  end
  else
  begin
    FState := Error;
    UpdateEvents(HRESULT, False, Self, 0, 0, 'Error',
      '', '', '', '', (ErrorText(HRESULT)), nil);
  end;
  if Assigned(OutputFile) then
  begin
    OutputFile.Free;
    OutputFile := nil;
  end;
  if Info.BindInfoValue = Info.BindInfoValue or BINDF_ASYNCHRONOUS then
  begin
    FSender.FObjList.Extract(Self); // Remove caused the error
    FSender.Items.Extract(Self); // Remove caused the error
  end;
  Binding._Release;
  Binding := nil;

  ClearAll; // releases binding ...
  // call update complete only on real complete or abort
  if Assigned(FSender.FOnDownloadComplete) then
    FSender.FOnDownloadComplete(Self, Stream, HRESULT);
  if (FSender.DownloadMethod <> dlStream) and (Info.FileName <> '') then
    FSender.FDownloadedFile := FSender.FDownloadDir + '\' + Info.FileName
  else
    FSender.FDownloadedFile := '';
  FSender.BusyStateChange;
  Self := nil;
  Self.Free;
end;

{IUnknown Interface}

function TBSCB.QueryInterface(const IID: TGUID; out Obj): HRESULT;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TBSCB._AddRef: Integer;
begin
  Result := InterlockedIncrement(FSender.FRefCount);
end;

function TBSCB._Release: Integer;
begin
  Result := InterlockedDecrement(FSender.FRefCount);
  if Result = 0 then
    Destroy;
end;

{IWindowForBindingUI Interface}

function TBSCB.GetWindow(const GUIDReason: TGUID; out hwnd): HRESULT;
begin
  if Assigned(FSender.FGetWindow) then
    Result := FSender.FGetWindow(self, GUIDReason, LongWord(hwnd))
  else
    Result := S_OK;
end;

function TBSCB.GetFileNameFromUrl(Url: WideString): WideString;
{var
   i: Integer;
begin // will name as the address like: bsalsa.com
   i := Length(Url);
   repeat
      Result := Url[i] + Result;
      Dec(i);
   until (Url[i] = '/') or (i = 0); }
var
  Ut: TUrl;
begin
  Ut := TUrl.Create(Url);
  Ut.CrackUrl(Url, ICU_ESCAPE);
  if AnsiPos('.', Ut.ExtraInfo) = 0 then
    Result := FSender.FDefaultUrlFileName
  else
    Result := Ut.ExtraInfo;
end;

procedure TBSCB.SetFileName(FileName: string);
begin
  if (Info.FileName <> FileName) then
  begin
    Info.FileName := FileName;
    Info.FileExt := ExtractFileExt(FileName);
    if (Length(Info.FileExt) > 0) then
      Delete(Info.FileExt, 1, 1);
    // remove period character that separates the name and extension parts
  end;
end;

function TBSCB.GetContentDispFilename(): HRESULT;
const
  CD_FILE_PARAM = 'filename=';
var
  i: Integer;
  sTmp: string;
  res: Boolean;
begin
  Result := E_FAIL;
  res := QueryInfo(HTTP_QUERY_CONTENT_DISPOSITION, sTmp);
  if not res then
    Exit;
  // Content-Disposition: attachment; filename=genome.jpeg; modification-date="Wed, 12 Feb 1997 16:29:51 -0500";
  i := Pos(CD_FILE_PARAM, sTmp);
  if (i > 0) then
  begin
    sTmp := Copy(sTmp, i + Length(CD_FILE_PARAM), Length(sTmp) - i);
    if (sTmp[1] = '"') then
      i := Pos('";', sTmp)
    else
      i := Pos(';', sTmp);
    //TODO: what's happen, if the filename contains a quotion mark?
    if (i > 0) then
      sTmp := Copy(sTmp, 1, i);
    if (sTmp[1] = '"') then
      FileName := Copy(sTmp, 2, Length(sTmp) - 2)
    else
      FileName := sTmp;
    if (Length(sTmp) > 0) then
      Result := S_OK;
  end;
end;

function TBSCB.CheckCancelState: Integer;
begin
  if FSender.FCancel or (FState = Canceled) then
  begin
    Binding.Abort;
    Result := E_ABORT;
    UpdateEvents(Result, False, Self, 0, 0, 'Aborted.',
      '0', '0', '0', '0', 'Aborted.', nil);
  end
  else
    Result := S_OK;
end;

procedure TBSCB.TimerExpired(Sender: TObject);
begin
  FTimedOut := True;
end;

procedure TBSCB.Initialize;
begin
  ClearAll;
  FState := Requested;
  StartTick := GetTickCount;
  FInitializeTime := Now;
  FBSCBTimer := TTimer.Create(nil);
  FBSCBTimer.OnTimer := TimerExpired;
  FBSCBTimer.Interval := Info.TimeOut;
  FTimedOut := False;
  FSender := TIEDownload(Info.Sender);
{$IFDEF DELPHI_7_UP}
  GetLocaleFormatSettings(LOCALE_USER_DEFAULT, FormatSettings);
  //   FormatSettings.LongTimeFormat := 'mm:ss.zzz';
{$ENDIF}
end;

constructor TBSCB.Create(DownloadInfo: TInfo);
var
  Ut: TUrl;
begin
  inherited Create;
  Info := DownloadInfo;
  Initialize;
  Url := Info.Url;
  Ut := TUrl.Create(Url);
  try
    Ut.QueryUrl(Url);
    FileName := Ut.Document;
  finally
    Ut.Free;
  end;
  if (Info.FileName = '') then
    Stream := TMemoryStream.Create;
  UpdateEvents(S_OK, True, Self, 0, 0, 'Starting...',
    '', '', '', '', 'Starting...', nil);
  if CheckCancelState = E_Abort then
    Exit
  else
    Download()
end;

constructor TBSCB.Create(DownloadInfo: TInfo; pmk: IMoniker; pbc: IBindCtx);
var
  Ut: TUrl;
begin
  inherited Create;
  Info := DownloadInfo;
  Initialize;
  FMoniker := pmk;
  FBindCtx := pbc;
  FMoniker.GetDisplayName(FBindCtx, nil, Url);
  Info.Url := Url;
  Ut := TUrl.Create(Url);
  try
    Ut.QueryUrl(Url);
    FileName := Ut.Document;
  finally
    Ut.Free;
  end;
  UpdateEvents(S_OK, True, Self, 0, 0, 'Starting...',
    '', '', '', '', 'Starting...', nil);
  if CheckCancelState = E_Abort then
    Exit
  else
    DownloadCtx;
end;

function TBSCB.DownloadCtx: HRESULT;
var
  HR: HRESULT;
  pPrevBSCB, tmp: IBindStatusCallback;
begin
  Result := S_FALSE;

  HR := RegisterBindStatusCallback(FBindCtx, self, pPrevBSCB, 0);
  if ((FAILED(HR)) and Assigned(pPrevBSCB)) then
  begin
    HR := FBindCtx.RevokeObjectParam('_BSCB_Holder_');
    if (SUCCEEDED(HR)) then
    begin
      //Attempt register again, should succeed now
      HR := RegisterBindStatusCallback(FBindCtx, self, tmp, 0);
      if (SUCCEEDED(HR)) then
      begin
        //Need to pass a pointer for BindCtx and previous BSCB to our implementation
        m_pPrevBSCB := pPrevBSCB;
        self._AddRef();
        m_pPrevBSCB._AddRef();
        FBindCtx._AddRef();
      end;
    end;
  end;
  HR := FMoniker.BindToStorage(FBindCtx, nil, IStream, FStream);

  if (HR <> S_OK) and (HR <> MK_S_ASYNCHRONOUS) then
  begin
    if Assigned(FSender.FOnDownloadComplete) then
      FSender.FOnDownloadComplete(self, Stream, HR);
    if (FSender.DownloadMethod <> dlStream) and (Info.FileName <> '') then
      FSender.FDownloadedFile := FSender.FDownloadDir + '\' + Info.FileName
    else
      FSender.FDownloadedFile := '';
    Exit;
  end
  else
    HR := S_OK;

  Result := HR;
end;

destructor TBSCB.Destroy;
begin
  ClearAll;
  if Assigned(FBSCBTimer) then
    FreeAndNil(FBSCBTimer);
  if Assigned(OutputFile) then
    FreeAndNil(OutputFile);
  if Assigned(Stream) then
    FreeAndNil(Stream);
  Info.AdditionalHeader.Free;
  if (FGlobalData <> 0) then
    GlobalFree(FGlobalData);
  inherited;
end;

function TBSCB.Download: HRESULT;
var
  HR: HRESULT;
  OleStrUrl: POleStr;
begin
  Result := S_False;
  OleStrUrl := StringToOleStr(Info.Url);
  try
    HR := CreateURLMonikerEx(nil, OleStrUrl, FMoniker, URL_MK_LEGACY);
    if (HR <> S_OK) then
    begin
      UpdateEvents(HR, False, Self, 0, 0, 'Error creating Moniker.',
        '0', '0', '0', '0', 'Error creating Moniker.', nil);
      Exit;
    end;
    HR := CreateAsyncBindCtx(0, SELF, nil, FBindCtx);
    if (HR <> S_OK) then
    begin
      UpdateEvents(HR, False, Self, 0, 0, 'Error creating Async Bind.',
        '0', '0', '0', '0', 'Error creating Async Bind.', nil);
      Exit;
    end;
    HR := UrlMon.IsValidUrl(FBindCtx, OleStrUrl, 0);
    if HR <> S_OK then
    begin
      UpdateEvents(MK_E_SYNTAX, False, Self, 0, 0, 'Error in syntax.',
        '0', '0', '0', '0', 'Error in syntax.', nil);
      Exit;
    end;
    HR := FMoniker.BindToStorage(FBindCtx, nil, IStream, FStream);

    if (HR <> S_OK) and (HR <> MK_S_ASYNCHRONOUS) then
    begin
      UpdateEvents(MK_E_SYNTAX, False, Self, 0, 0, 'Error in Bind To Storage.',
        '0', '0', '0', '0', 'Error in Bind To Storage.', nil);
      Exit;
    end
    else
    begin
      Result := S_OK;
    end;
  finally
    SysFreeString(OleStrUrl);
  end;
end;

procedure TBSCB.ClearAll;
begin
  if Assigned(Binding) then
    Binding.Abort;
  FMoniker := nil;
  FBindCtx := nil;
  FGlobalData := 0;
  FTotalRead := 0;
  FDataAvailable := 0;
  FStartTime := 0;
  m_pPrevBSCB := nil;
end;

function TBSCB.QueryInfo(dwOption: DWORD; var Info: Cardinal): Boolean;
var
  HttpInfo: IWinInetHttpInfo;
  C: Cardinal;
  BufferLength: Cardinal;
  Reserved, dwFlags: Cardinal;
begin
  if (Assigned(Binding) and (Binding.QueryInterface(IWinInetHttpInfo, HttpInfo)
    = S_OK)) then
  begin
    Info := 0;
    Reserved := 0;
    dwFlags := 0;
    BufferLength := SizeOf(Cardinal);
    Result := not Boolean(HttpInfo.QueryInfo(dwOption or HTTP_QUERY_FLAG_NUMBER,
      @C, BufferLength, dwFlags, Reserved));
    HttpInfo := nil;
    if Result then
      Info := C;
  end
  else
    Result := False;
end;

function TBSCB.QueryInfo(dwOption: DWORD; var Info: string): Boolean;
var

  Buf: array[0..INTERNET_MAX_PATH_LENGTH] of char;
  HttpInfo: IWinInetHttpInfo;
  BufLength, dwReserved, dwFlags: Cardinal;
begin
  if (Assigned(Binding) and (Binding.QueryInterface(IWinInetHttpInfo, HttpInfo)
    = S_OK)) then
  begin
    Info := '';
    dwReserved := 0;
    dwFlags := 0;
    BufLength := INTERNET_MAX_PATH_LENGTH + 1;
    Result := not Boolean(HttpInfo.QueryInfo(dwOption, @Buf, BufLength, dwFlags,
      dwReserved));
    HttpInfo := nil;
    if Result then
      Info := Buf;
  end
  else
    Result := False;
end;

function TBSCB.QueryInfo(dwOption: DWORD; var Info: TDateTime): Boolean;
var
  HttpInfo: IWinInetHttpInfo;
  SysTime: TSystemtime;
  BufferLength: Cardinal;
  Reserved, dwFlags: Cardinal;
begin
  if (Assigned(Binding) and (Binding.QueryInterface(IWinInetHttpInfo, HttpInfo)
    = S_OK)) then
  begin
    Info := 0;
    Reserved := 0;
    dwFlags := 0;
    BufferLength := SizeOf(TSystemTime);
    Result := not Boolean(HttpInfo.QueryInfo(dwOption or
      HTTP_QUERY_FLAG_SYSTEMTIME,
      @SysTime, BufferLength, dwFlags, Reserved));
    HttpInfo := nil;
    if Result then
      Info := SystemTimeToDateTime(SysTime);
  end
  else
    Result := False;
end;

function TBSCB.GetBindResult(out clsidProtocol: TCLSID; out dwResult: DWORD;
  out szResult: POLEStr): HRESULT;
var
  dwReserved: DWORD;
begin
  dwReserved := 0;
  Result := Binding.GetBindResult(clsidProtocol, dwResult, szResult,
    dwReserved);
end;

function TBSCB.GetSaveFileAs: WideString;
begin
  if not DirectoryExists(Info.DownloadDir) then
    CreateDir(Info.DownloadDir + '\');
  Result := Info.DownloadDir + '\' + Info.FileName;

  //   ' Info.FileName' + Info.FileName);
   {	if (Copy(Info.DownloadDir, Length(Info.DownloadDir), 1) = '\') then
    Result := Info.DownloadDir + Info.FileName
    else
      Result := Info.DownloadDir + '\' + Info.FileName; }
end;

// BSCBList---------------------------------------------------------------------

function TBSCBList.byURL(Url: string): TBSCB; //by Jury Gerasimov
var
  i: integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if Items[i].Info.Url = Url then
    begin
      Result := Items[i];
      break;
    end;
end;

function TBSCBList.GetItem(Index: Integer): TBSCB;
begin
  Result := TBSCB(inherited GetItem(Index));
end;

procedure TBSCBList.SetItem(Index: Integer; Value: TBSCB);
begin
  inherited SetItem(Index, Value);
end;

procedure TBSCB.UpdateEvents(Code: integer; BusyState: Boolean; Sender: TBSCB;
  ulProgress, ulProgressMax: ULONG; szStatusText: LPCWSTR; Downloaded,
  ElapsedTime,
  Speed, RemainingTime, Status: string; Stream: TStream);
begin
  with FSender do
  begin
    if (Code >= 0) and (Code < 99) then
      if Assigned(FOnStatusText) then
        FOnStatusText(Self, BindStatusText(Code));
    if (Code = 0) or ((Code > 99) and (Code < 506)) then
      if Assigned(FOnRespondText) then
        FOnRespondText(Self, ResponseCodeText(Code));
    if (Code < -10000) or (Code > 12000) then
      if Assigned(FOnErrorText) then
      begin
        FOnErrorText(Self, ErrorText(Code));
        if Assigned(FOnRespondText) then
          FOnRespondText(Self, '');
        if Assigned(FOnStatusText) then
          FOnStatusText(Self, 'Download Error.');
      end;
    if Assigned(FOnProgress) then
    begin
      OnProgress(Sender, ulProgress, ulProgressMax, Code, szStatusText,
        Downloaded, ElapsedTime, Speed, RemainingTime, Status);
    end;
  end;
end;

// IEDownload-------------------------------------------------------------------

constructor TIEDownload.Create(AOwner: TComponent);
begin
  inherited;
  FDefaultUrlFileName := 'index.html';
  FCodePageOption := Ansi;
  FProxySettings := TProxySettings.Create;
  FProxySettings.FPort := 80;
  FUrlEncodeOptions := [];
  FDefaultProtocol := 'http://';
  FObjList := TObjectList.Create;
  Items := TBSCBList.Create;
  FAdditionalHeader := TStringlist.Create;
  FAdditionalHeader.Add('Content-Type: application/x-www-form-urlencoded ');
  FRange := TRange.Create;
  FSecurity := TSecurity.Create;
  FBindInfoOptions := [Asynchronous, AsyncStorage, PullData, NoWriteCache,
    GetNewestVersion];
  FBindVerbOption := Get; //Method;
  FCodePageOption := Ansi; //Ansi Code page;
  SetUserAgent;
end;

procedure TIEDownload.Loaded;
begin
  inherited Loaded;
  SetUserAgent;
  FRefCount := 1;
  FBusy := False;
  if (FProxySettings.FAutoLoadProxy) and (FProxySettings.FServer <> '') then
    FProxySettings.SetProxy(FullUserAgent, FProxySettings.FServer + ':' +
      IntToStr(FProxySettings.FPort));
end;

destructor TIEDownload.Destroy;
begin
  FObjList.Free;
  Items.Free;
  FRange.Free;
  FSecurity.Free;
  FAdditionalHeader.Free;
  if FProxySettings.FAutoLoadProxy then
    FProxySettings.SetProxy('', '');
  FProxySettings.Free;
  inherited;
end;

procedure TIEDownload.SetUserAgent;
begin
  FullUserAgent := USER_AGENT_IE6 + '(' + FUserAgent + ')' + #13#10;
end;

function TIEDownload.SetHostName: WideString;
type
  TProtocols = array[1..22] of string;
const
  Protocols: TProtocols = (
    'about', 'cdl', 'dvd', 'file', 'ftp', 'gopher', 'http', 'ipp', 'its',
    'javascript', 'local',
    'mailto', 'mk', 'msdaipp', 'ms-help', 'ms-its', 'mso', 'res', 'sysimage',
    'tv', 'vbscript', 'via');
var
  i: Integer;
begin
  for i := 1 to 21 do
  begin
    if (AnsiPos(AnsiUpperCase(Protocols[i]), AnsiUpperCase(FUrl)) <> 0) then
    begin
      Result := FUrl;
      Exit;
    end;
  end;
  FUrl := 'http://' + FUrl;
  Result := FUrl;
end;

function TIEDownload.SetDownloadDir: Boolean;
begin
  if (FDownloadDir = '') and (FDownloadMethod <> dlStream) then
    FDownloadDir := ExtractFilePath(Application.ExeName) + 'Downloads\';
  Result := CreateDir(FDownloadDir);
end;

procedure TIEDownload.Cancel;
begin
  FCancel := True;
  BusyStateChange;
end;

procedure TIEDownload.Cancel(Item: TBSCB);
begin
  Item.FState := Canceled;
  BusyStateChange;
end;

procedure TIEDownload.FillInfo(var Info: TInfo);
begin
  with Info do
  begin
    Sender := Self;
    DownloadDir := Self.DownloadDir;
    AdditionalHeader.AddStrings(FAdditionalHeader);
    BindVerbValue := FBindVerbValue;
    BindInfoValue := FBindInfoValue;
    Password := FPassword;
    UserName := FUserName;
    CustomVerb := FCustomVerb;
    ExtraInfo := FExtraInfo;
    PostData := FPostData;
    PutFileName := FPutFileName;
    Descriptor := Security.Descriptor;
    InheritHandle := Security.InheritHandle;
    RangeBegin := Range.RangeBegin;
    RangeEnd := Range.RangeEnd;
    UrlEncodeValue := FUrlEncodeValue;
    CodePageValue := FCodePageValue;
    TimeOut := FTimeOut;
    OpenAfterDownload := False;
    FileSize := 0;
  end;
end;

procedure TIEDownload.Go(Url: WideString);
var
  Info: TInfo;
  BS: TBSCB;
begin
  BusyStateChange;
  FCancel := False;
  FUrl := Url;
  FUrl := SetHostName;
  Info.Url := StringToOleStr(FUrl);
  Info.FileName := '';
  Info.AdditionalHeader := TStringlist.Create;
  FillInfo(Info);

  BS := TBSCB.Create(Info);
  if FBindInfoValue <> FBindInfoValue or BINDF_ASYNCHRONOUS then
  try
  finally
    BS.Free;
  end
  else
  begin
    FObjList.Add(BS);
    Items.Add(BS);
  end;
end;

{function TIEDownload.Go(URLx: WideString): TBSCB;
var
   Info: TInfo;
begin
   FCancel := False;
   FUrl := URLx;
   FUrl := AddPrefixHttp;
   Info.Url := StringToOleStr(FUrl);
   Info.FileName := '';
   Info.AdditionalHeader := TStringlist.Create;
   FillInfo(Info);
   Result := TBSCB.Create(Info);
   if FBindInfoValue = FBindInfoValue or BINDF_ASYNCHRONOUS then
      begin
         FObjList.Add(Result);
         Items.Add(Result);
      end;
end; }

function TIEDownload.Go(Url: Widestring; FileName: WideString): TBSCB;
var
  Info: TInfo;
begin
  FCancel := False;
  FUrl := Url;
  FUrl := SetHostName;
  Info.Url := StringToOleStr(FUrl);
  Info.FileName := FileName;
  Info.AdditionalHeader := TStringlist.Create;
  FillInfo(Info);
  Result := TBSCB.Create(Info);
  if FBindInfoValue = FBindInfoValue or BINDF_ASYNCHRONOUS then
  begin
    FObjList.Add(Result);
    Items.Add(Result);
  end;
end;

procedure TIEDownload.Download(pmk: IMoniker; pbc: IBindCtx);
var
  Info: TInfo;
  BS: TBSCB;
begin
  BusyStateChange;
  FCancel := False;
  Info.Url := '';
  Info.FileName := '';
  Info.AdditionalHeader := TStringlist.Create;
  FillInfo(Info);
  BS := TBSCB.Create(Info, pmk, pbc);
  if FBindInfoValue <> FBindInfoValue or BINDF_ASYNCHRONOUS then
  try

  finally
    BS.Free;
  end
  else
  begin
    FObjList.Add(BS);
    Items.Add(BS);
  end;
end;

procedure TIEdownload.UpdateUrlEncodeValue;
const
  acardUrlEncodeValues: array[TUrlEncodeOption] of Cardinal = (
    $00000001, $00000002);
var
  i: TUrlEncodeOption;
begin
  FUrlEncodeValue := 0;
  if (FUrlEncodeOptions <> []) then
    for i := Low(TUrlEncodeOption) to High(TUrlEncodeOption) do
      if (i in FUrlEncodeOptions) then
        Inc(FUrlEncodeValue, acardUrlEncodeValues[i]);
end;

procedure TIEDownload.SetUrlEncodeOptions(const Value: TUrlEncodeOptions);
begin
  FUrlEncodeOptions := Value;
  UpdateUrlEncodeValue;
end;

procedure TIEDownload.SetDownloadMethod(const Value: TDownloadMethod);
begin
  FDownloadMethod := Value;
end;

procedure TIEDownload.UpdateBindInfoValue;
const
  acardBindInfoValues: array[TBindInfoOption] of Cardinal = (
    $00000001, $00000002, $00000004, $00000008, $00000010, $00000020, $00000040,
    $00000080,
    $00000100, $00000200, $00000400, $00000800, $00001000, $00002000, $00004000,
    $00008000,
    $00010000, $00020000, $00040000, $00080000, $00100000, $00200000, $00400000,
    $00800000);
var
  i: TBindInfoOption;
begin
  FBindInfoValue := 0;
  if (FBindInfoOptions <> []) then
    for i := Low(TBindInfoOption) to High(TBindInfoOption) do
      if (i in FBindInfoOptions) then
        Inc(FBindInfoValue, acardBindInfoValues[i]);
end;

procedure TIEDownload.SetBindInfoOptions(const Value: TBindInfoOptions);
begin
  if FFileExistsOption = feOverwrite then
    FBindInfoOptions := FBindInfoOptions + [GetNewestVersion];
  FBindInfoOptions := Value;
  UpdateBindInfoValue;
end;

procedure TIEDownload.SetCodePageOption(const Value: TCodePageOption);
begin
  FCodePageOption := Value;
  case FCodePageOption of
    Ansi: FCodePageValue := CP_ACP;
    Mac: FCodePageValue := CP_MACCP;
    OEM: FCodePageValue := CP_OEMCP;
    Symbol: FCodePageValue := CP_SYMBOL;
    ThreadsAnsi: FCodePageValue := CP_THREAD_ACP;
    UTF7: FCodePageValue := CP_UTF7;
    UTF8: FCodePageValue := CP_UTF8;
  end;
end;

procedure TIEDownload.SetBindVerbOption(const Value: TBindVerbOption);
begin
  FBindVerbOption := Value;
  case FBindVerbOption of
    Get: FBindVerbValue := BINDVERB_GET;
    Put: FBindVerbValue := BINDVERB_PUT;
    Post: FBindVerbValue := BINDVERB_POST;
    Custom: FBindVerbValue := BINDVERB_CUSTOM;
  end;
end;

procedure TIEDownload.SetAdditionalHeader(const Value: Tstrings);
begin
  FAdditionalHeader.Assign(Value);
end;

procedure TIEDownload.SetDefaultProtocol(const Value: string);
begin
  FDefaultProtocol := (Value);
  if FDefaultProtocol = '' then
    FDefaultProtocol := 'http://';
end;

procedure TIEDownload.BusyStateChange;
begin
  if FBusy then
    FBusy := False
  else
    FBusy := True;
  if Assigned(FOnBusy) then
    FOnBusy(Self);
end;

//------------------------------------------------------------------------------

function TProxySettings.SetProxy(FullUserAgent, ProxyServer: string): Boolean;
//mladen
var
  list: INTERNET_PER_CONN_OPTION_LIST;
  dwBufSize: DWORD;
  hInternet: Pointer;
  Options: array[1..3] of INTERNET_PER_CONN_OPTION;
begin
  Result := False;
  dwBufSize := SizeOf(list);
  list.dwSize := SizeOf(list);
  list.pszConnection := nil;
  list.dwOptionCount := High(Options);
  // the highest index of the array (in this case 3)
  Options[1].dwOption := INTERNET_PER_CONN_FLAGS;
  Options[1].Value.dwValue := PROXY_TYPE_DIRECT or PROXY_TYPE_PROXY;
  Options[2].dwOption := INTERNET_PER_CONN_PROXY_SERVER;
  Options[2].Value.pszValue := PChar(ProxyServer);
  Options[3].dwOption := INTERNET_PER_CONN_PROXY_BYPASS;
  Options[3].Value.pszValue := '<local>';
  list.pOptions := @Options;

  hInternet := InternetOpen(PChar(FullUserAgent), INTERNET_OPEN_TYPE_DIRECT,
    nil, nil, 0);
  if hInternet <> nil then
  try
    Result := InternetSetOption(hInternet,
      INTERNET_OPTION_PER_CONNECTION_OPTION, @list, dwBufSize);
    Result := Result and InternetSetOption(hInternet, INTERNET_OPTION_REFRESH,
      nil, 0);
  finally
    InternetCloseHandle(hInternet)
  end;
end;

initialization
  coInitialize(nil);
finalization
  coUninitialize;
end.

