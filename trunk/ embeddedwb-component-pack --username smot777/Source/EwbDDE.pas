//*************************************************************
//                          Ewb_DDE                           *
//                                                            *
//                     Freeware Unit                          *
//                       For Delphi                           *
//                            by                              *
//          Eran Bodankin (bsalsa) -(bsalsa@bsalsa.com)       *
//          Mathias Walter (mich@matze.tv)                    *
//                                                            *
//       Documentation and updated versions:                  *
//                                                            *
//               http://www.bsalsa.com                        *
//*************************************************************
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

You may use/ change/ modify the component under 4 conditions:
1. In your website, add a link to "http://www.bsalsa.com"
2. In your application, add credits to "Embedded Web Browser"
3. Mail me  (bsalsa@bsalsa.com) any code change in the unit  for the benefit
   of the other users.
4. Please, consider donation in our web site!
{*******************************************************************************}

unit EwbDDE;

interface

uses
  Windows, Classes, ShellAPI, EWBAcc, Registry, EwbTools, ShlObj, IEConst,
  sysUtils, ActiveX, ComObj;

type
  TEwb_DDE = class(TThread)
end;

procedure GetDDEVariables;
function GetCommandTypeFromDDEString(szCommand: string): UINT;
function GetPathFromDDEString(szCommand: string; var szFolder: string): Boolean;
function GetPidlFromDDEString(szCommand: string): PItemIDList;
function GetShowCmdFromDDEString(szCommand: string): Integer;
function ParseDDECommand(szCommand: string; var szFolder: string;
  var pidl: PItemIDList; var show: Integer): UINT;
procedure DisposePIDL(ID: PItemIDList);

implementation

uses
  EwbCoreTools;

var
  FindFolder, OpenFolder, ExploreFolder, HtmlFileApp, HtmlFileTopic: string; //All DDE variables
  FoldersApp, FoldersTopic: string;

procedure DisposePIDL(ID: PItemIDList);
var
  Malloc: IMalloc;
begin
  if ID <> nil then
  begin
    OLECheck(SHGetMalloc(Malloc));
    Malloc.Free(ID);
  end;
end;

procedure GetDDEVariables;
var
  s: string;
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  with Reg do
  try
    RootKey := HKEY_CLASSES_ROOT;
    OpenKey('htmlfile\shell\open\ddeexec\application', False);
    HtmlFileApp := Readstring('');
    CloseKey;
    OpenKey('htmlfile\shell\open\ddeexec\topic', False);
    HtmlFileTopic := ReadString('');
    CloseKey;
    OpenKey('Folder\shell\open\ddeexec\application', False);
    FoldersApp := Readstring('');
    CloseKey;
    OpenKey('Folder\shell\open\ddeexec\topic', False);
    FoldersTopic := ReadString('');
    CloseKey;
    OpenKey('Folder\shell\open\ddeexec', False);
    s := readString('');
    CloseKey;
    S := Copy(S, Pos('[', S) + 1, length(S));
    OpenFolder := Copy(s, 1, Pos('(', S) - 1);
    OpenKey('Folder\shell\explore\ddeexec', False);
    s := readString('');
    CloseKey;
    S := Copy(S, Pos('[', S) + 1, length(S));
    ExploreFolder := Copy(s, 1, Pos('(', S) - 1);
    OpenKey('Directory\shell\find\ddeexec', False);
    s := readString('');
    CloseKey;
    S := Copy(S, Pos('[', S) + 1, length(S));
    FindFolder := Copy(s, 1, Pos('(', S) - 1);
  finally
    Free;
  end;
end;

function GetCommandTypeFromDDEString(szCommand: string): UINT;
begin
  szCommand := Copy(szCommand, Pos('[', szCommand) + 1, length(szCommand));
  szCommand := Copy(szCommand, 1, Pos('(', szCommand) - 1);
  if szCommand = Openfolder then
    Result := VIEW_COMMAND
  else
    if szCommand = Explorefolder then
      Result := EXPLORE_COMMAND
    else
      if szCommand = Findfolder then
        Result := FIND_COMMAND
      else
        Result := NO_COMMAND;
end;

function GetPathFromDDEString(szCommand: string; var szFolder: string): Boolean;
begin
  szCommand := Copy(szCommand, Pos('"', szCommand) + 1, length(szCommand));
  szFolder := Copy(szCommand, 1, Pos('"', szCommand) - 1);
  Result := (szFolder <> '');
end;

function GetPidlFromDDEString(szCommand: string): PItemIDList;
var
  pidlShared, pidlGlobal: PItemIDList;
  dwProcessID: Integer;
  hShared: THandle;
  s: string;
  ProcessID: string;
  i: Integer;
begin
  s := Copy(szCommand, Pos(',', szCommand) + 1, length(szCommand));
  i := 1;
  while not (CharInSet(s[i], IsDigit) and (i <= Length(s))) do
    Inc(i);
  processID := Copy(s, i, Length(S));
  s := Copy(S, i, length(s) - 1);
  i := 1;
  while CharInSet(s[i], IsDigit) and (i <= Length(s)) do
    Inc(i);
  s := Copy(S, 1, i - 1);

  while not ((ProcessID[i] = ':') or (ProcessID[i] = ',')) and (i <= Length(processID)) do
    Inc(i);
  if ProcessID[i] = ':' then
  begin
    ProcessID := Copy(ProcessID, i, Length(ProcessID));
    i := 1;
    while not (CharInSet(ProcessID[i], IsDigit) and (i <= Length(ProcessID))) do
      Inc(i);
    ProcessID := Copy(ProcessID, i, Length(ProcessID));
    i := 1;
    while (CharInSet(ProcessID[i], IsDigit)) and (i <= Length(ProcessID)) do
      Inc(i);
    if not (CharInSet(ProcessID[i], IsDigit)) then
      ProcessID := Copy(ProcessID, 1, i - 1);
  end
  else
    ProcessID := '0';
  dwProcessID := StrToInt(ProcessID);
  if dwProcessID <> 0 then
  begin
    hShared := StrToInt(s);
    pidlShared := ShLockShared(hShared, dwProcessId);
    if PidlShared <> nil then
    begin
      Result := CopyPidl(PidlShared);
      ShUnlockShared(pidlShared);
    end
    else
      Result := nil;
    ShFreeShared(hShared, dwProcessID);
  end
  else
  begin
    pidlGlobal := PItemIDList(StrToInt(s));
    Result := CopyPidl(pidlGlobal);
    _Free(pidlGlobal);
  end;
end;

function GetShowCmdFromDDEString(szCommand: string): Integer;
var
  i: Integer;
begin
  i := 1;
  while szCommand[i] <> ',' do
    Inc(i);
  Inc(i);
  while szCommand[i] <> ',' do
    Inc(i);
  szCommand := Copy(szCommand, i, Length(szCommand));
  i := 0;
  repeat
    inc(i)
  until (i > Length(szCommand)) or CharInSet(szCommand[i], IsDigit);
  if i <= length(szCommand) then
    Result := StrtoInt(szCommand[i])
  else
    Result := 1;
end;

function ParseDDECommand(szCommand: string; var szFolder: string;
  var pidl: PItemIDList; var show: Integer): UINT;
begin
  Result := GetCommandTypeFromDDEString(szCommand);
  if Result <> NO_COMMAND then
  begin
    GetPathFromDDEString(szCommand, szFolder);
    pidl := GetPidlFromDDEString(szCommand);
    show := GetShowCmdFromDDEString(szCommand);
  end;
end;

end.

