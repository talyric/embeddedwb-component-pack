unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw_EWB, EwbCore, EmbeddedWB, ActiveX,
  AppEvnts, ExtCtrls;

type
  TForm1 = class(TForm)
    EmbeddedWB1: TEmbeddedWB;
    Button1: TButton;
    Timer1: TTimer;
    ListBox1: TListBox;
    EmbeddedWB2: TEmbeddedWB;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    ListBox2: TListBox;
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure EmbeddedWB1KeyDown(Sender: TObject; Key, ScanCode: Word;
      Shift: TShiftState);
    procedure EmbeddedWB1Message(Sender: TObject; var Msg: TMessage;
      var Handled: Boolean);
    procedure EmbeddedWB1KeyUp(Sender: TObject; Key, ScanCode: Word;
      Shift: TShiftState);
    procedure EmbeddedWB1MousePressed(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation


uses Unit2, UMsgText;

{$R *.dfm}


function GetParentWindow(Handle: HWND; const ClassName: string): HWND;
var
  szClass: array[0..255] of char;
begin
  Result := GetParent(Handle);
  while IsWindow(Result) do
  begin
    if (GetClassName(Result, szClass, SizeOf(szClass)) > 0) and
      (AnsiStrComp(PChar(ClassName), szClass) = 0) then Exit;
    Result := GetParent(Result);
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if sCREEN.ActiveForm.ActiveControl <> nil then

    Caption := sCREEN.ActiveForm.ActiveControl.Name + '-' + Inttostr(GetParentWindow(GetFocus, 'Shell Embedding'));
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Form2.Show;
end;

procedure TForm1.EmbeddedWB1KeyDown(Sender: TObject; Key, ScanCode: Word;
  Shift: TShiftState);
begin
  Listbox1.itemindex := Listbox1.items.add('EmbeddedWB1KeyDown')
end;

procedure TForm1.EmbeddedWB1Message(Sender: TObject; var Msg: TMessage;
  var Handled: Boolean);
begin
if assigned(Listbox2) then
  Listbox2.ItemIndex := Listbox2.Items.add(inttostr(msg.msg) +'%' +inttostr(msg.LParam) +'%' +inttostr(msg.WParam) +'%' +MsgCode2Text(msg.msg));

end;

procedure TForm1.EmbeddedWB1KeyUp(Sender: TObject; Key, ScanCode: Word;
  Shift: TShiftState);
begin
   Listbox1.itemindex := Listbox1.items.add('EmbeddedWB1KeyUp')
end;

procedure TForm1.EmbeddedWB1MousePressed(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    Listbox1.itemindex := Listbox1.items.add('EmbeddedWB1MousePressed '+ inttostr(x) +'--'+ inttostr(y))
end;

end.

