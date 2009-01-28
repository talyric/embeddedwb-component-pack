program Project1;

uses
  Forms,
  unit1 in '..\WBWheelFalshTest\unit1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
