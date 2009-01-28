unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, OleCtrls, SHDocVw_EWB, EwbCore, EmbeddedWB;

type
  TForm2 = class(TForm)
    WebBrowser1: TEmbeddedWB;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Timer1: TTimer;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
 Close;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  WebBrowser1.Go('www.google.com');
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  WebBrowser1.Go('c:\');
end;

procedure TForm2.Timer1Timer(Sender: TObject);
var
  Control: TWinControl;
begin
  Control := ActiveControl;
  if Control <> nil then
    Label1.Caption := 'Active Control: ' + ActiveControl.Name;
end;

end.
