unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw_EWB, EwbCore, EmbeddedWB, SHDocVw;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    EmbeddedWB1: TEmbeddedWB;
    CheckBox1: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure EmbeddedWB1NewWindow2(ASender: TObject;
      var ppDisp: IDispatch; var Cancel: WordBool);
  private
    { Private declarations }
    NewForm: TForm;
    NewWB: TEmbeddedWB;
    procedure NewWBWindowSetHeight(ASender: TObject; Height: Integer);
    procedure NewWBWindowSetWidth(ASender: TObject; Width: Integer);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.NewWBWindowSetHeight(ASender: TObject; Height: Integer);
var
  heightDiff, widthDiff: Integer;
begin
  heightDiff := NewForm.Height - NewWB.Height;
  NewForm.Height := heightDiff + Height;
end;

procedure TForm1.NewWBWindowSetWidth(ASender: TObject; Width: Integer);
var
  heightDiff, widthDiff: Integer;
begin
  widthDiff := NewForm.Width - NewWB.Width;
  NewForm.Width := widthDiff + Width;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
//  caption := Booltostr(TEWB(EmbeddedWB1).RegisterasDropTarget);
//   EmbeddedWB1.Navigate('www.google.com');
caption := Booltostr(EmbeddedWB1.DefaultInterface.Silent) + Booltostr(EmbeddedWB1.Silent)
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 EmbeddedWB1.Navigate('http://www.primustel.ca/en/business/magma.html');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  EmbeddedWB1.RegisterasDropTarget := not EmbeddedWB1.RegisterasDropTarget;
end;

procedure TForm1.EmbeddedWB1NewWindow2(ASender: TObject;
  var ppDisp: IDispatch; var Cancel: WordBool);
begin
 if checkbox1.checked then Exit;
// Create a new form
  NewForm := TForm.Create(Self);

  // Create a new TEmbeddedWB
  NewWB := TEmbeddedWB.Create(NewForm);

  // Assign OnWindowSetHeight and OnWindowSetWidth handlers to 
//  // the new TEmbeddedWB
  NewWB.OnWindowSetHeight := NewWBWindowSetHeight;
  NewWB.OnWindowSetWidth := NewWBWindowSetWidth;

  // Set the new TEmbeddedWB on the new Form 
  TWinControl(NewWB).Parent := NewForm;

  NewWB.Visible := True;
  NewWB.Align := alClient;
 // NewWB.DefaultInterface.RegisterAsBrowser := True;
  NewWB.RegisterAsBrowser := True;
  // Display the URL in NewWB
  ppDisp := NewWB.Application;

  // Make the new Form visible
  NewForm.Visible := True;

end;

end.

