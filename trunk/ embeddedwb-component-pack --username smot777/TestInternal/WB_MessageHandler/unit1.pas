unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, StdCtrls, ExtCtrls, AppEvnts, Menus, ActiveX,
  SHDocVw_EWB, EwbCore, EmbeddedWB, ComCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ListBox1: TListBox;
    Timer1: TTimer;
    ApplicationEvents1: TApplicationEvents;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    RightClickMenu1: TMenuItem;
    ShowMyPopup1: TMenuItem;
    N5: TMenuItem;
    EnableAllMenus: TMenuItem;
    N3: TMenuItem;
    DisableAllMenu1: TMenuItem;
    DisableDefaultMenu1: TMenuItem;
    DisableImagesMenu1: TMenuItem;
    DisableTableMenu1: TMenuItem;
    DisableSelectedTextMenu1: TMenuItem;
    DisableControlsMenu1: TMenuItem;
    DisableAnchorMenu1: TMenuItem;
    DisableUnknownMenu1: TMenuItem;
    DisableImgDynSrcMenu1: TMenuItem;
    DisableDebugMenu1: TMenuItem;
    DisableImageArtMenu1: TMenuItem;
    N1: TMenuItem;
    N4: TMenuItem;
    Note1: TMenuItem;
    Note2: TMenuItem;
    N2: TMenuItem;
    DisableViewSource1: TMenuItem;
    DisableOpenInANewWindow1: TMenuItem;
    DisableOpenLink1: TMenuItem;
    Shortcuts1: TMenuItem;
    DisableCtrlN1: TMenuItem;
    DisableCtrlP1: TMenuItem;
    DisableCtrlA1: TMenuItem;
    N6: TMenuItem;
    EnableAll1: TMenuItem;
    EmbeddedWB1: TEmbeddedWB;
    UpDown1: TUpDown;
    Button2: TButton;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);

    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure EmbeddedWB1TranslateAccelerator(Sender: TCustomEmbeddedWB;
      const lpMsg: PMsg; const pguidCmdGroup: PGUID; const nCmdID: Cardinal;
      var Done: Boolean);
    procedure Button2Click(Sender: TObject);
    procedure DisableAllMenu1Click(Sender: TObject);
    procedure DisableCtrlN1Click(Sender: TObject);
    procedure DisableViewSource1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
//    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}



 function MyGetClassName(Wnd: HWND): string;
var
  buf: array[0..255] of char;
begin
  GetClassName(wnd, buf, SizeOf(buf) - 1);
  Result := StrPas(buf);
end;



procedure TForm1.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);

 function ProcessKeyForBrowser(WB: TEmbeddedWB; const Msg: TMsg): Boolean;
  var
    Key: TWMKey;
    Result2: Boolean;
  begin
    ZeroMemory(@Key, SizeOf(Key));
    Key.Msg := Msg.message;
    Key.CharCode := msg.wParam;
    Key.KeyData := msg.lParam;
    Key.Result := 0;
    Result := Screen.ActiveForm.IsShortCut(Key);
    if Result then
      Listbox1.ItemIndex := Listbox1.Items.Add('Res1 '+ BoolTostr(Result));

  {  Result2 := SendAppMessage(CM_APPKEYDOWN, Key.CharCode, key.KeyData) <> 0;

    if Result2 then
      Listbox1.ItemIndex := Listbox1.Items.Add('Res2 '+ BoolTostr(Result2));
  }


    { or
    (SendAppMessage(CM_APPKEYDOWN, Word(Msg.wParam),
      Msg.lParam) = 0)};
  end;

const
  StdKeys = [VK_TAB, VK_RETURN, VK_BACK]; { standard keys }
  ExtKeys = [VK_DELETE, VK_LEFT, VK_RIGHT, VK_UP, VK_DOWN]; { extended keys }
  fExtended = $01000000; { extended key flag }
var
  CurrentWB: TEmbeddedWB;
begin
   Handled := False;
   CurrentWB := EmbeddedWB1;

   if  Assigned(CurrentWB.Document) then
   begin
   if IsChild(CurrentWB.Handle, Msg.Hwnd) then
   begin
      if  (KeyDataToShiftState(msg.lParam) = [ssAlt]) then
   begin
    Handled := False;
    Exit;
   end;
      case Msg.message of
      WM_KEYDOWN:
      begin
        Handled := ProcessKeyForBrowser(CurrentWB, Msg);
        if Handled then Exit;
       end;
     end;

     Handled:=(IsDialogMessage(CurrentWB.Handle, Msg) = True);
     if Handled and not CurrentWB.Busy then
      if ((Msg.Message >= WM_KEYFIRST) and (Msg.Message <= WM_KEYLAST)) and
        ((Msg.wParam in StdKeys) or (GetKeyState(VK_CONTROL) < 0) or
        (Msg.wParam in ExtKeys) and ((Msg.lParam and fExtended) = fExtended)) then
      begin
        Handled := (CurrentWB.Application as IOleInPlaceActiveObject).TranslateAccelerator(Msg) = S_OK;
        if not Handled then
        begin
          Handled := True;
          TranslateMessage(Msg);
          DispatchMessage(Msg);
        end;
      end;
    end;
end;
end;



procedure TForm1.Button1Click(Sender: TObject);
begin
//  EmbeddedWB1.Navigate('http://www.rafb.net/paste/');
  EmbeddedWB1.Navigate('http://www.pjirc.com/chat/HeavyApplet.php?nick=Guest???')
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  EmbeddedWB1.Navigate('http://examples.adobe.com/flex2/inproduct/sdk/explorer/explorer.html');
end;

procedure TForm1.DisableAllMenu1Click(Sender: TObject);
begin
Label1.caption :='Alt+E';
end;

procedure TForm1.DisableCtrlN1Click(Sender: TObject);
begin
  Label1.caption :='CTRL+Alt+N';
end;

procedure TForm1.DisableViewSource1Click(Sender: TObject);
begin
Label1.caption :='F3';
end;

procedure TForm1.EmbeddedWB1TranslateAccelerator(Sender: TCustomEmbeddedWB;
  const lpMsg: PMsg; const pguidCmdGroup: PGUID; const nCmdID: Cardinal;
  var Done: Boolean);
const
  // Set of all browser keystrokes that should be left intact,
  // i.e. they are processed normally by the browser.
  AllowedBrowserKeys = [VK_PRIOR, VK_NEXT, VK_END, VK_HOME,
    VK_LEFT, VK_UP, VK_RIGHT, VK_DOWN];
var
  KeyMsg: TWMKey;
begin

Done := False;
Exit;
  // Create a new TWMKey message record based on the lpMsg parameter.
  ZeroMemory(@KeyMsg, SizeOf(KeyMsg));
  with lpMsg^ do
  begin
    KeyMsg.Msg := message;
    KeyMsg.CharCode := Word(wParam);
    KeyMsg.KeyData := lParam;
  end;
  // Preserve the browser's default keystroke processing.
  Done := FALSE;
  // (1) Test the message's CharCode against the set of all allowed keystrokes.
  // (2) Try to find and execute action associated with the current keystroke
  //     on the current form (if there is any).
  // (3) If the previous step failed, repeat it again, but in this case,
  //     on the main application form. This takes care of cases when the browser
  //     is placed on a secondary form.
  if not (KeyMsg.CharCode in AllowedBrowserKeys) then
    if (IsShortCut(KeyMsg) or (SendAppMessage(CM_APPKEYDOWN, KeyMsg.CharCode,
      KeyMsg.KeyData) = 0)) then
    begin
      // Forces the browser not to respond to the current keystroke.
      Done := True;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  EmbeddedWB1.Navigate('http://rudyscott.com/SampleFlash.html');
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
Caption := mygetclassname(Getfocus);
end;

end.
