unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw_EWB, EwbCore, StdCtrls, AppEvnts, EmbeddedWB,
  ExtCtrls, SHDocVw, Buttons, activex;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    EmbeddedWB1: TEmbeddedWB;
    ApplicationEvents1: TApplicationEvents;
    Timer1: TTimer;
    Memo1: TMemo;
    SpeedButton1: TSpeedButton;
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EmbeddedWB1DocumentComplete(ASender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure ApplicationEvents2Activate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG;
      var Handled: Boolean);
    procedure EmbeddedWB1Enter(Sender: TObject);
    procedure EmbeddedWB1Exit(Sender: TObject);
  private
    { Private declarations }

    procedure ApplicationActivate(Sender:TObject);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2, mshtml;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
//  HookChildWindows;

  EmbeddedWB1.Navigate('www.google.ch');

//  EmbeddedWB1.Navigate('http://examples.adobe.com/flex2/inproduct/sdk/explorer/explorer.html');
end;





procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
Form2.Show;
end;



procedure TForm1.Timer1Timer(Sender: TObject);
var
  Control: TWinControl;
begin
  Control := ActiveControl;
  if Control <> nil then
    Caption := 'Active Control: ' + ActiveControl.Name
end;


procedure TForm1.FormCreate(Sender: TObject);
begin

//  EmbeddedWB1.HandleNeeded;
//  Application.OnActivate:=ApplicationActivate;
//  EmbeddedWB1.AssignEmptyDocument;


end;

procedure TForm1.EmbeddedWB1DocumentComplete(ASender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
//  (ASender as TEmbeddedWB).SetFocusToDoc
caption := '123';
end;



procedure TForm1.ApplicationEvents2Activate(Sender: TObject);
begin
 { if ActiveControl is TEmbeddedWB then
  begin
    ActiveControl := EmbeddedWB1;
    EmbeddedWB1.Focused;
    EmbeddedWB1.SetFocusToDoc;
  end;  }
//  ShowMessage('Mein Anwendung wurde grade aktiviert2 !');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  EmbeddedWB1.SetFocusToDoc;

end;

procedure TForm1.ApplicationActivate(Sender: TObject); 
begin
//ShowMessage('Mein Anwendung wurde grade aktiviert !');
end;

procedure SendWBKey;
var
  wnd :HWND; 
begin 
  wnd := FindWindowEx(Form1.EmbeddedWB1.Handle,0,'Shell DocObject View',nil);
  wnd := FindWindowEx(wnd ,0,'Internet Explorer_Server',nil); 
  if wnd <> 0 then 
  begin
   // *** (Webbrowser1.Document as IHTMLDocument2).ParentWindow.Focus; *** // ist wahrscheinlich nicht notwendig 
     PostMessage(wnd, WM_KEYDOWN , VK_LEFT, 0);
     PostMessage(wnd, WM_KEYUP , VK_LEFT, 0);
  end;
end;


procedure TForm1.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
var
  iOIPAO: IOleInPlaceActiveObject;
  Dispatch: IDispatch;
begin
  // exit if we don't get back a webbrowser object
{
  if (EmbeddedWB1 = nil) then
  begin
    Handled := false;
    exit;
  end;

  Handled := (IsDialogMessage(EmbeddedWB1.Handle, Msg) = True);

  if (Handled) and (not EmbeddedWB1.Busy) then
  begin
    if FOleInPlaceActiveObject = nil then
    begin
      Dispatch := EmbeddedWB1.Application;
      if Dispatch <> nil then
      begin
        Dispatch.QueryInterface(IOleInPlaceActiveObject, iOIPAO);
        if iOIPAO <> nil then FOleInPlaceActiveObject := iOIPAO;
      end;
    end;
    if FOleInPlaceActiveObject <> nil then
    begin
      if ((Msg.message = WM_KEYDOWN) or (Msg.message = WM_KEYUP)) and
      ((Msg.wParam = VK_BACK) or (Msg.wParam = VK_LEFT) or (Msg.wParam = VK_RIGHT)) then
      begin
        Caption := inttostr(Msg.wParam)
        //nothing - do not pass on Backspace, Left or Right arrows
      end else
         FOleInPlaceActiveObject.TranslateAccelerator(Msg);
    end;
  end;      }
end;

procedure TForm1.EmbeddedWB1Enter(Sender: TObject);
begin
  caption := 'Enter';
end;

procedure TForm1.EmbeddedWB1Exit(Sender: TObject);
begin
 caption := 'Exit';
end;

end.

