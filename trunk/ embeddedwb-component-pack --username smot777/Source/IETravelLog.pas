//***********************************************************
//                          IETravelLog                     *
//                                                          *
//                     Freeware Component                   *
//                            by                            *
//                     Per Linds� Larsen                    *
//                   per.lindsoe@larsen.mail.dk             *
//                Updated by Eran Bodankin - bsalsa         *
//                     bsalsa@bsalsa.com                    *
//                                                          *
//        Documentation and updated versions:               *
//                                                          *
//               http://www.bsalsa.com                      *
//***********************************************************
{*******************************************************************************}
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
4. Please consider donation in our web site!
{*******************************************************************************}
//$Id: IETravelLog.pas,v 1.3 2006/12/18 14:13:07 bsalsa Exp $

unit IETravelLog;

interface

{$I EWB_Compilers.inc}

uses
  Activex, Windows, Classes, EmbeddedWB, IEConst, EwbAcc;

type
  TOnEntryEvent = procedure(Title, Url: WideString; var Cancel: Boolean) of object;
  TOnGetCountEvent = procedure(Flags: Cardinal; out Entries: Cardinal) of object;
  TOnRemoveEntryEvent = procedure(Name: WideString; var Cancel: Boolean) of object;
  TOnTravelToEvent = procedure(Offset: Integer; var Cancel: Boolean) of object;

  TIETravelLog = class(TComponent)
  private
    { Private declarations }
    FAbout: string;
    FEmbeddedWB: TEmbeddedWB;
    FEnabled: Boolean;
    FOnEntry: TOnEntryEvent;
    FOnGetCount: TOnGetCountEvent;
    FOnRemoveEntry: TOnRemoveEntryEvent;
    FOnTravelTo: TOnTravelToEvent;
    procedure SetAbout(Value: string);
  protected
    { Protected declarations }
    Entry: ITravelLogEntry;
    Enum: IEnumTravelLogEntry;
    Stg: ITravelLogStg;
    procedure _Enumerate(Flags: Cardinal);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    function Connect: Boolean;
    function CreateEntry(Offset: Integer; URL, Title: WideString): HRESULT;
    function GetCount(Flags: DWORD; out Entries: DWORD): HRESULT;
    function GetRelativeEntry(Offset: Integer; out Title, Url: WideString): HRESULT;
    function RemoveEntry(Offset: Integer): HRESULT;
    function RemoveEntryByTitle(Title: WideString): HRESULT;
    function RemoveEntryByUrl(Url: WideString): HRESULT;
    function TravelTo(Offset: Integer): HRESULT;
    procedure ClearSession;
    procedure Enumerate;
    procedure EnumerateBack;
    procedure EnumerateForward;
  published
    { Published declarations }
    property About: string read FAbout write SetAbout;
    property EmbeddedWB: TEmbeddedWB read FEmbeddedWB write FEmbeddedWB;
    property OnEntry: TOnEntryEvent read FOnEntry write FOnEntry;
    property OnGetCount: TOnGetCountEvent read FOnGetCount write FOnGetCount;
    property OnRemoveEntry: TOnRemoveEntryEvent read FOnRemoveEntry write FOnRemoveEntry;
    property OnTravelTo: TOnTravelToEvent read FOnTravelTo write FOnTravelTo;
    property Enabled: boolean read FEnabled write FEnabled default True;
  end;

implementation

{ TIETravelLog }

constructor TIETravelLog.Create(AOwner: TComponent);

begin
  inherited Create(AOwner);
  FAbout := 'TIETravelLog. ' + WEB_SITE;
  FEnabled := True;
end;

procedure TIETravelLog.SetAbout(Value: string);
begin
  Exit;
end;

function TIETravelLog.TravelTo(Offset: Integer): HRESULT;
var
  Cancel: Boolean;
begin
  Cancel := False;
  Result := S_False;
  if FEnabled and Assigned(EmbeddedWB) and Assigned(EmbeddedWB.Document) and
    (Stg.GetRelativeEntry(OffSet, Entry) = S_OK) then
  begin
    if Assigned(FOnTravelTo) then
      FOnTravelTo(OffSet, Cancel);
  end;
  if not Cancel then
    Result := Stg.TravelTo(Entry);
end;

procedure TIETravelLog._Enumerate(Flags: Cardinal);
var
  Cancel: Boolean;
  Fetched: Cardinal;
  Url, Title: PWideChar;
begin
  if FEnabled and Assigned(EmbeddedWB) and Assigned(EmbeddedWB.Document) then
  begin
    Cancel := False;
    Stg.EnumEntries(Flags, Enum);
    if Enum <> nil then
      while (enum.next(1, Entry, Fetched) = S_OK) and not Cancel do
      begin
        if Assigned(FOnEntry) and Succeeded(Entry.GetTitle(Title)) and Succeeded(Entry.GetUrl(Url)) then
          FonEntry(Title, url, Cancel);
      end;
  end;
end;

procedure TIETravelLog.EnumerateBack;
begin
  if FEnabled and Assigned(EmbeddedWB) and Assigned(EmbeddedWB.Document) then
    _Enumerate(TLEF_RELATIVE_BACK);
end;

procedure TIETravelLog.EnumerateForward;
begin
  if FEnabled and Assigned(EmbeddedWB) and Assigned(EmbeddedWB.Document) then
    _Enumerate(TLEF_RELATIVE_FORE);
end;

function TIETravelLog.Connect: Boolean;
var
  ISP: IServiceProvider;
begin
  Result := False;
  if FEnabled and Assigned(EmbeddedWB) and Assigned(EmbeddedWB.Document) then
  begin
    if Succeeded(EmbeddedWB.Application.QueryInterface(IServiceprovider, ISP)) and
      Succeeded(ISP.QueryService(SID_STravelLogCursor, IID_ITravelLogStg, Stg)) then
      Result := True;
  end;
end;

function TIETravelLog.GetRelativeEntry(Offset: Integer; out Title, Url: WideString): HRESULT;
var
  WUrl, WTitle: PWideChar;
begin
  Result := S_False;
  if FEnabled and Assigned(EmbeddedWB) and Assigned(EmbeddedWB.Document) then
    Result := Stg.GetRelativeEntry(OffSet, Entry);
  if Result = S_OK then
  begin
    if Succeeded(Entry.GetTitle(WTitle)) then
      Title := WTitle;
    if Succeeded(Entry.GetUrl(WUrl)) then
      Url := WUrl;
  end;
end;

function TIETravelLog.GetCount(Flags: DWORD; out Entries: DWORD): HRESULT;
begin
  Result := S_False;
  if FEnabled and Assigned(EmbeddedWB) and Assigned(EmbeddedWB.Document) then
  begin
    Result := Stg.GetCount(Flags, Entries);
    if Assigned(FOnGetCount) then
      FOnGetCount(Flags, Entries);
  end;
end;

function TIETravelLog.CreateEntry(Offset: Integer; URL, Title: WideString): HRESULT;
var
  Dummy: ITravelLogEntry;
begin
  Result := S_False;
  if FEnabled and Assigned(EmbeddedWB) and Assigned(EmbeddedWB.Document) and
    (Stg.GetRelativeEntry(OffSet, Entry) = S_OK)
    then
    Result := Stg.CreateEntry(StringToOleStr(Url), StringToOleStr(Title), Entry, TRUE, Dummy)
end;

procedure TIETravelLog.Enumerate;
begin
  if FEnabled and Assigned(EmbeddedWB) and Assigned(EmbeddedWB.Document) then
    _Enumerate(TLEF_ABSOLUTE);
end;

function TIETravelLog.RemoveEntry(Offset: Integer): HRESULT;
var
  Title, Url: WideString;
  Cancel: Boolean;
begin
  Cancel := False;
  Result := S_False;
  if FEnabled and Assigned(EmbeddedWB) and Assigned(EmbeddedWB.Document) and
    (GetRelativeEntry(Offset, Title, Url) = S_OK) then
  begin
    if Assigned(FOnRemoveEntry) then
      FOnRemoveEntry(Title, Cancel);
    if not Cancel then
      Result := RemoveEntryByUrl(Url);
  end;
end;

function TIETravelLog.RemoveEntryByTitle(Title: WideString): HRESULT;
var
  Fetched: Cardinal;
  PTitle: PWideChar;
  Cancel: Boolean;
begin
  Cancel := False;
  Result := S_False;
  if FEnabled and Assigned(EmbeddedWB) and Assigned(EmbeddedWB.Document) and
    (Stg.EnumEntries(TLEF_ABSOLUTE, Enum) = S_OK) then
    while (enum.next(1, Entry, Fetched) = S_OK) do
    begin
      if Succeeded(Entry.GetTitle(PTitle)) and (Title = pTitle) then
      begin
        if Assigned(FOnRemoveEntry) then
          FOnRemoveEntry(Title, Cancel);
        if not Cancel then
          Result := Stg.RemoveEntry(Entry);
      end;
    end;
end;

function TIETravelLog.RemoveEntryByUrl(Url: WideString): HRESULT;
var
  Fetched: Cardinal;
  PUrl: PWideChar;
  Cancel: Boolean;
begin
  Cancel := False;
  Result := S_False;
  if FEnabled and Assigned(EmbeddedWB) and Assigned(EmbeddedWB.Document) and
    (Stg.EnumEntries(TLEF_ABSOLUTE, Enum) = S_OK)
    then
    while (enum.next(1, Entry, Fetched) = S_OK) do
    begin
      if Succeeded(Entry.GetUrl(PUrl)) and (Url = pUrl) then
      begin
        if Assigned(FOnRemoveEntry) then
          FOnRemoveEntry(Url, Cancel);
        if not Cancel then
          Result := Stg.RemoveEntry(Entry);
      end;
    end;
end;

procedure TIETravelLog.ClearSession;
var
  Fetched: Cardinal;
begin
  if FEnabled and Assigned(EmbeddedWB) and Assigned(EmbeddedWB.Document) and
    (Stg.EnumEntries(TLEF_ABSOLUTE, Enum) = S_OK) then
    while (Enum.Next(1, Entry, Fetched) = S_OK) do
      Stg.RemoveEntry(Entry);
end;

end.

