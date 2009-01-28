unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw_EWB, EwbCore,  EmbeddedWB, StdCtrls, ExtCtrls, WinInet;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    WebBrowser1: TEmbeddedWB;
    WebBrowser2: TEmbeddedWB;
    ListBox2: TListBox;
    Button3: TButton;
    Timer1: TTimer;
    Button4: TButton;
    Button5: TButton;
    Panel2: TPanel;
    Button8: TButton;
    procedure ListBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
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
  ActiveX, mshtml, EWBTools, Unit2;

const
  HTML_TEST_PAGE =
    '<html>' + #13#10 +
    '<head>' + #13#10 +
    '</head>' + #13#10 +
    '<body>' + #13#10 +
    '    <h1><font color="#ff8000">%s Page</font>' + #13#10 +
    '    </h1>' + #13#10 +
    '    <p>' + #13#10 +
    '        <font size="2"><font size="3">Steps:</font> </font>' + #13#10 +
    '    </p>' + #13#10 +
    '    <ol>' + #13#10 +
    '        <li>' + #13#10 +
    '            <font size="2">Click on&nbsp;an item in the list. </font>' + #13#10 +
    '        </li>' + #13#10 +
    '        <li>' + #13#10 +
    '            <font size="2">Click on this web page. </font>' + #13#10 +
    '        </li>' + #13#10 +
    '        <li>' + #13#10 +
    '            <font size="2">Click back on the list box. </font>' + #13#10 +
    '        </li>' + #13#10 +
    '        <li>' + #13#10 +
    '            <font size="2">Press the up and down arrow key. </font>' + #13#10 +
    '        </li>' + #13#10 +
    '        <li>' + #13#10 +
    '            <font size="2">You should see the browser scroll up and down and not selected item' + #13#10 +
    '            in the listbox move up and down.</font>' + #13#10 +
    '        </li>' + #13#10 +
    '        <li>' + #13#10 +
    '            <font size="2">Now check the <b>"Use TWebBroserFocusMonitor Control"</b>.</font>' + #13#10 +
    '        </li>' + #13#10 +
    '        <li>' + #13#10 +
    '            <font size="2">Perform steps&nbsp;1 through 4.</font>' + #13#10 +
    '        </li>' + #13#10 +
    '        <li>' + #13#10 +
    '            <font size="2">This up and down keys should more the selected item in the listbox' + #13#10 +
    '            up and down.</font>' + #13#10 +
    '        </li>' + #13#10 +
    '    </ol>' + #13#10 +
    '    <table border="0">' + #13#10 +
    '        <tbody>' + #13#10 +
    '            <tr>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <p>' + #13#10 +
    '                        <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font>' + #13#10 +
    '                    </p>' + #13#10 +
    '                </td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '            </tr>' + #13#10 +
    '            <tr>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '            </tr>' + #13#10 +
    '            <tr>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '            </tr>' + #13#10 +
    '            <tr>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '            </tr>' + #13#10 +
    '            <tr>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '            </tr>' + #13#10 +
    '            <tr>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '            </tr>' + #13#10 +
    '            <tr>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '            </tr>' + #13#10 +
    '            <tr>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '            </tr>' + #13#10 +
    '            <tr>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '            </tr>' + #13#10 +
    '            <tr>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '            </tr>' + #13#10 +
    '            <tr>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '            </tr>' + #13#10 +
    '            <tr>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '            </tr>' + #13#10 +
    '            <tr>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '            </tr>' + #13#10 +
    '            <tr>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '            </tr>' + #13#10 +
    '            <tr>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '            </tr>' + #13#10 +
    '            <tr>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '            </tr>' + #13#10 +
    '            <tr>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '            </tr>' + #13#10 +
    '            <tr>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '            </tr>' + #13#10 +
    '            <tr>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '            </tr>' + #13#10 +
    '            <tr>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '            </tr>' + #13#10 +
    '            <tr>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '            </tr>' + #13#10 +
    '            <tr>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '            </tr>' + #13#10 +
    '            <tr>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #0080ff" color="white">test</font></td>' + #13#10 +
    '                <td>' + #13#10 +
    '                    <font style="BACKGROUND-COLOR: #ff8000" color="white">test</font></td>' + #13#10 +
    '            </tr>' + #13#10 +
    '        </tbody>' + #13#10 +
    '    </table>' + #13#10 +
    '</body>' + #13#10 +
    '</html>';


procedure LoadDocFromString(WB: TEmbeddedWB; const HTMLString: string);
var
  v: OleVariant;
  HTMLDocument: IHTMLDocument2;
  Res: IHtmlDocument2;
begin
  if not Supports(WB.Document, IHtmlDocument2, Res) then Exit;
  HTMLDocument := WB.Document as IHTMLDocument2;
  v := VarArrayCreate([0, 0], varVariant);
  v[0] := HTMLString;
  HTMLDocument.Write(PSafeArray(TVarData(v).VArray));
  HTMLDocument.Close;

end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin
  LoadDocFromString(WebBrowser1, Format(HTML_TEST_PAGE, [ListBox1.Items[ListBox1.ItemIndex]]));
  LoadDocFromString(WebBrowser2, Format(HTML_TEST_PAGE, [ListBox1.Items[ListBox1.ItemIndex]]));
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  WebBrowser1.Navigate('about:blank');
//  WebBrowser2.GoAboutBlank;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  WebBrowser1.Go('www.google.com');
  WebBrowser2.Go('www.google.com');
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  WebBrowser1.ShowFindDialog;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  Control: TWinControl;
begin
  Control := ActiveControl;
  if Control <> nil then
    Caption := 'Active Control: ' + ActiveControl.Name
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Form2.show;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  WebBrowser2.Refresh;
end;

end.

