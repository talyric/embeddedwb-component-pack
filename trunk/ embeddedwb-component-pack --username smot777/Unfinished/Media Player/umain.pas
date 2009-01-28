unit umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, OleCtrlsFix, SHDocVw_EWB, EwbCore, EmbeddedWB,
  ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button4: TButton;
    Button3: TButton;
    Button2: TButton;
    Button1: TButton;
    Panel2: TPanel;
    EmbeddedWB1: TEmbeddedWB;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure EmbeddedWB1DocumentComplete(ASender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
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
  MSHTML;



procedure TForm1.Button1Click(Sender: TObject);

var
  TheDocument: IHTMLdocument2;
  Hidden1: IHTMLElement;
begin
  try
    TheDocument := EmbeddedWB1.document as IHTMLdocument2;
    Hidden1 := TheDocument.all.item('startplayer', 0) as IHTMLElement;
    Hidden1.click;
    Button2.Enabled := True;
    Button3.Enabled := True;
    Button1.Enabled := False;
  except
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  TheDocument: IHTMLdocument2;
  Hidden1: IHTMLElement;
begin
  try
    TheDocument := EmbeddedWB1.document as IHTMLdocument2;
    Hidden1 := TheDocument.all.item('stopplayer', 0) as IHTMLElement;
    Hidden1.click;
    Button1.Enabled := True;
    Button2.Enabled := False;
    Button3.Enabled := False;
  except
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  TheDocument: IHTMLdocument2;
  Hidden1: IHTMLElement;
begin
  if (Sender as TButton).Tag = 0 then
  begin
    try
      TheDocument := EmbeddedWB1.document as IHTMLdocument2;
      Hidden1 := TheDocument.all.item('pauseplayer', 0) as IHTMLElement;
      Hidden1.click;
    except
    end;
    (Sender as TButton).Tag := 1;
    Button3.Caption := 'Unpause';
  end
  else
  begin
    try
      TheDocument := EmbeddedWB1.document as IHTMLdocument2;
      Hidden1 := TheDocument.all.item('unpauseplayer', 0) as IHTMLElement;
      Hidden1.click;
    except
    end;
    (Sender as TButton).Tag := 0;
    Button3.Caption := 'Pause';
  end;

end;

procedure TForm1.Button4Click(Sender: TObject);

var
  TheDocument: IHTMLdocument2;
  Hidden1: IHTMLElement;
begin
  try
    TheDocument := EmbeddedWB1.document as IHTMLdocument2;
    Hidden1 := TheDocument.all.item('rewindplayer', 0) as IHTMLElement;
    Hidden1.click;
  except
  end;
end;

procedure TForm1.EmbeddedWB1DocumentComplete(ASender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
  Button1.Enabled := True;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  AppPath: string;
begin
  AppPath := ExtractFilePath(Application.ExeName);
  EmbeddedWB1.Go('file:///' + AppPath + 'Player.htm');
end;

end.

