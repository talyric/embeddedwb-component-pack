unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw_EWB, EwbCore, EmbeddedWB;

type
  TForm1 = class(TForm)
    EWB: TEmbeddedWB;
    Button1: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure EWBDownloadComplete(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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
 MSHTML_EWB;

procedure TForm1.Button1Click(Sender: TObject);
begin
 EWB.Go('www.google.com');
end;



procedure TForm1.EWBDownloadComplete(Sender: TObject);
begin
if checkbox1.checked then
    AutoHideScrollBars1(EWB, True);
if checkbox2.checked then
   AutoHideScrollBars2(EWB, True);

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
if checkbox1.checked then
  AutoHideScrollBars1(EWB, True);
if checkbox2.checked then
  AutoHideScrollBars2(EWB, True);
end;

end.
