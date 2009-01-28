unit uMain;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  Dialogs, EwbBehaviorsComp, EwbEventsComp, EwbEvents, OleCtrls, SHDocVw_EWB, MSHTML_EWB, EwbCore,
  EmbeddedWB, StdCtrls, ComObj, ActiveX, ExtCtrls;

type
  TForm1 = class(TForm)
    EmbeddedWB1: TEmbeddedWB;
    HtmlListener1: THtmlListener;
    Panel1: TPanel;
    Button1: TButton;
    lblClickedOnElement: TLabel;
    lblElementUndertheMouse: TLabel;
    procedure HtmlListener1HandlersOnClickHandle(Sender: TObject;
      Event: IHTMLEventObj);
    procedure FormCreate(Sender: TObject);
    procedure HtmlListener1HandlersOnMouseMoveHandle(Sender: TObject;
      Event: IHTMLEventObj);
    procedure EmbeddedWB1DocumentComplete(ASender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FEventsEnabled: Boolean;
    HubLink: IHubLink;
    procedure DisconnectHtmlListener;
    procedure ConnectHtmlListener(ASender: TObject);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FEventsEnabled := True;
  EmbeddedWB1.Navigate('www.bsalsa.com');
end;

procedure TForm1.HtmlListener1HandlersOnClickHandle(Sender: TObject;
  Event: IHTMLEventObj);
begin
  lblClickedOnElement.Caption := Format('Clicked on Element with Tag: [%s]', [Event.srcElement.tagName])
end;

procedure TForm1.HtmlListener1HandlersOnMouseMoveHandle(Sender: TObject;
  Event: IHTMLEventObj);
begin
  lblElementUndertheMouse.Caption := Format('Element under the Mouse [%s]', [Event.srcElement.tagName])
end;

procedure TForm1.ConnectHtmlListener(ASender: TObject);
var
  Doc: IHTMLDocument2;
  CPC: IConnectionPointContainer;
begin
  if not Assigned(HubLink) then
  begin
    Doc := (ASender as TEmbeddedWB).Doc2;
    if Assigned(Doc) then
    begin
      Doc.QueryInterface(IConnectionPointContainer, CPC);
      if Assigned(CPC) then
        HubLink := HtmlListener1.Connect2(CPC);
    end;
  end;
end;

procedure TForm1.DisconnectHtmlListener;
begin
  if Assigned(HubLink) then
  begin
    HubLink.Disconnect;
    HubLink := nil;
  end;
end;

procedure TForm1.EmbeddedWB1DocumentComplete(ASender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
  if FEventsEnabled then
    if pDisp = (ASender as TEmbeddedWB).DefaultInterface then
      ConnectHtmlListener(ASender);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if FEventsEnabled then
  begin
    DisconnectHtmlListener;
    Button1.Caption := 'Enable Events';
    FEventsEnabled := False;
  end else
  begin
    ConnectHtmlListener(EmbeddedWB1);
    Button1.Caption := 'Disable Events';
    FEventsEnabled := True;
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  DisconnectHtmlListener;
end;

end.

