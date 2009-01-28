unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw_EWB, EwbCore, EmbeddedWB, ExtCtrls,
  ComCtrls, EWBTools;

type
  TForm1 = class(TForm)
    EmbeddedWB1: TEmbeddedWB;
    ListBox1: TListBox;
    Panel1: TPanel;
    Button2: TButton;
    Button1: TButton;
    Button6: TButton;
    chkFieldType: TCheckBox;
    chkFieldName: TCheckBox;
    chkFieldValue: TCheckBox;
    Bevel1: TBevel;
    edFieldName: TEdit;
    edFieldValue: TEdit;
    Bevel2: TBevel;
    cbElementType: TComboBox;
    edNewValue: TEdit;
    Label1: TLabel;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Label2: TLabel;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button7: TButton;
    FindDialog1: TFindDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure EmbeddedWB1BusyWait(AStartTime: Cardinal; Abort: Boolean);
    procedure Button4Click(Sender: TObject);
    procedure EmbeddedWB1WindowStateChanged(Sender: TObject; dwFlags,
      dwValidFlagsMask: Integer);
    procedure Button7Click(Sender: TObject);
   // function EmbeddedWB1BusyWait(AStartTime: Cardinal; Abort : Boolean): Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TWBFindFieldMatchFlags = set of (ffMatchAll, ffMatchType, ffMatchName, ffMatchValue);

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  MSHTML_EWB;

function FindInputElement(Document: IDispatch; FieldType, FieldName, FieldValue: string;
  Flags: TWBFindFieldMatchFlags): IHTMLInputElement;
var
  i: Integer;
  bFieldType, bFieldName, bFieldValue: Boolean;
  bFieldFound: Boolean;
  Doc2: IHtmlDocument2;
  ElementsColl: IHTMLElementCollection;
  InputElem: IHTMLInputElement;
begin
  Result := nil;
  if Assigned(Document) then
  begin
    Document.QueryInterface(IHtmlDocument2, Doc2);
    if Assigned(Doc2) then
    begin
      ElementsColl := (Doc2.All as IHTMLElementCollection).tags('INPUT') as IHTMLElementCollection;
      if Assigned(ElementsColl) then
      begin
        for i := 0 to ElementsColl.length - 1 do
        begin
          InputElem := ElementsColl.Item(i, varEmpty) as IHTMLInputElement;
          if Assigned(InputElem) then
          begin
            bFieldType := SameText(InputElem.Type_, FieldType);
            bFieldName := SameText(InputElem.Name, FieldName);
            bFieldValue := SameText(InputElem.Value, FieldValue);

            bFieldFound := False;

            if Flags = [ffMatchType, ffMatchName, ffMatchValue] then Flags := [ffMatchAll];

            if (ffMatchAll in Flags) then bFieldFound := bFieldType and bFieldName and bFieldValue else
              if (ffMatchType in Flags) and (ffMatchName in Flags) then bFieldFound := bFieldType and bFieldName else
                if (ffMatchType in Flags) and (ffMatchValue in Flags) then bFieldFound := bFieldType and bFieldValue else
                  if (ffMatchName in Flags) and (ffMatchValue in Flags) then bFieldFound := bFieldName and bFieldValue else
                    if (ffMatchType in Flags) then bFieldFound := bFieldType else
                      if (ffMatchName in Flags) then bFieldFound := bFieldName else
                        if (ffMatchValue in Flags) then bFieldFound := bFieldValue;

            if bFieldFound then
            begin
              Result := InputElem;
              Exit;
            end;
          end;
        end;
      end;
    end;
  end;
end;


function ClickInputElement(Document: IDispatch; FieldType, FieldName, FieldValue: string;
  Flags: TWBFindFieldMatchFlags = [ffMatchAll]): Boolean;
var
  InputElem: IHTMLInputElement;
begin
  Result := False;
  begin
    InputElem := FindInputElement(Document, FieldType, FieldName, FieldValue, Flags);
    if Assigned(InputElem) then
    try
      (InputElem as IHTMLElement).Click;
      Result := True;
    except
      Result := False;
    end;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  Flags: TWBFindFieldMatchFlags;
begin
  Flags := [];
  if chkFieldType.Checked then Flags := Flags + [ffMatchType];
  if chkFieldName.Checked then Flags := Flags + [ffMatchName];
  if chkFieldValue.Checked then Flags := Flags + [ffMatchValue];

  ClickInputElement(EmbeddedWB1.Document, cbElementType.Text, edFieldName.Text, edFieldValue.Text, Flags)
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  caption := EmbeddedWB1.GetSelectedText(True)
// caption := EmbeddedWB1.SelText;
end;

function SetInputElementCheckState(Document: IDispatch; FieldType, FieldName, FieldValue: string;
  Flags: TWBFindFieldMatchFlags = [ffMatchAll]; Checked: Boolean = True): Boolean; overload;
var
  InputElem: IHTMLInputElement;
begin
  Result := False;
  begin
    InputElem := FindInputElement(Document, FieldType, FieldName, FieldValue, Flags);
    if Assigned(InputElem) then
    try
      InputElem.checked := Checked;
      Result := True;
    except
      Result := False;
    end;
  end;
end;

function SetInputElementCheckState(WB: TEmbeddedWB; FieldType, FieldName, FieldValue: string;
  Flags: TWBFindFieldMatchFlags = [ffMatchAll]; Checked: Boolean = True; bIncludeFrames: Boolean = True): Boolean; overload;
var
  i: Integer;
  Web2: IWebbrowser2;
  Document: IDispatch;
begin
  Document := nil;
  if bIncludeFrames then
    for i := 0 to WB.FrameCount - 1 do
    begin
      Web2 := WB.GetFrame(i);
      if Assigned(Web2) then
      begin
        Document := Web2.Document;
        SetInputElementCheckState(Document, FieldType, FieldName, FieldValue, Flags, Checked);
      end;
    end;
  if Document = nil then
  begin
    Document := WB.Document;
    SetInputElementCheckState(Document, FieldType, FieldName, FieldValue, Flags, Checked);
  end;
end;

function SetInputElementValue(Document: IDispatch; FieldType, FieldName, FieldValue: string;
  Flags: TWBFindFieldMatchFlags = [ffMatchAll]; NewFieldValue: string = ''): Boolean; overload;
var
  HTMLElement: IHTMLElement;
  InputElem: IHTMLInputElement;
begin
  Result := False;
  InputElem := FindInputElement(Document, FieldType, FieldName, FieldValue, Flags);
  if Assigned(InputElem) then
  begin
    try
      HTMLElement := InputElem as IHTMLElement;
      if Assigned(HTMLElement) then
      begin
        if SameText(HTMLElement.tagName, 'INPUT') then
        begin
          (HTMLElement as IHTMLInputElement).Value := NewFieldValue;
          Result := True;
        end
        else
          if SameText(HTMLElement.tagName, 'SELECT') then
          begin
            (HTMLElement as IHTMLSelectElement).Value := NewFieldValue;
            Result := True;
          end
          else
            if SameText(HTMLElement.tagName, 'TEXTAREA') then
            begin
              (HTMLElement as IHTMLTextAreaElement).Value := NewFieldValue;
              Result := True;
            end;
      end;
    except
      Result := False;
    end;
  end;
end;

function SetInputElementValue(WB: TEmbeddedWB; FieldType, FieldName, FieldValue: string;
  Flags: TWBFindFieldMatchFlags = [ffMatchAll]; NewFieldValue: string = ''; bIncludeFrames: Boolean = True): Boolean; overload;
var
  i: Integer;
  Web2: IWebbrowser2;
  Document: IDispatch;
begin
  Document := nil;
  if bIncludeFrames then
    for i := 0 to WB.FrameCount - 1 do
    begin
      Web2 := WB.GetFrame(i);
      if Assigned(Web2) then
      begin
        Document := Web2.Document;
        SetInputElementValue(Document, FieldType, FieldName, FieldValue, Flags, NewFieldValue);
      end;
    end;
  if Document = nil then
  begin
    Document := WB.Document;
    SetInputElementValue(Document, FieldType, FieldName, FieldValue, Flags, NewFieldValue);
  end;
end;



procedure TForm1.Button1Click(Sender: TObject);
begin
//  EmbeddedWB1.Go(ExtractFilePath(Paramstr(0)) + 'TestWebPage\frames_example.html');

  EmbeddedWB1.Go('file:///C:/Programme/Borland/Delphi6/Lib2/EmbeddedWB/TestInternal/RadioCheckbox/TestWebPage/content.html');

//   EmbeddedWB1.Go('http://netikka.net/jmi/testpage.html');

//  EmbeddedWB1.GoAboutBlank;
//  EmbeddedWB1.LoadFromString(Memo3.Text)
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Flags: TWBFindFieldMatchFlags;
begin
  Flags := [];
  if chkFieldType.Checked then Flags := Flags + [ffMatchType];
  if chkFieldName.Checked then Flags := Flags + [ffMatchName];
  if chkFieldValue.Checked then Flags := Flags + [ffMatchValue];

//  WB_SetInputElementCheckState(EmbeddedWB1, 'radio', 'Radio1', 'r2');

  case cbElementType.ItemIndex of
    0, 1: SetInputElementCheckState(EmbeddedWB1, cbElementType.Text, edFieldName.Text, edFieldValue.Text, Flags);
    2, 3, 4: SetInputElementValue(EmbeddedWB1, cbElementType.Text, edFieldName.Text, edFieldValue.Text, Flags, edNewValue.Text);
  end;
end;



//  SetRadioCheckboxField(EmbeddedWB1, 'radio', 'Radio1', 'r3', True, [ffMatchAll]);
//    SetRadioCheckboxField(EmbeddedWB1, 'Checkbox', 'agree', '', True, [ffMatchType, ffMatchName]);
 // SetRadioCheckboxField(EmbeddedWB1.Document, '', '', '', True, []);


procedure TForm1.Button6Click(Sender: TObject);
begin
  Embeddedwb1.Go('www.google.com');
  Embeddedwb1.Wait;
end;

procedure TForm1.EmbeddedWB1BusyWait(AStartTime: Cardinal; Abort: Boolean);
begin
  Label2.Caption := Inttostr(GetTickCount - AStartTime);
  Application.ProcessMessages;
end;

procedure TForm1.EmbeddedWB1WindowStateChanged(Sender: TObject; dwFlags,
  dwValidFlagsMask: Integer);
begin
  ShowMessage('invisible');
  if (dwValidFlagsMask = OLECMDIDF_WINDOWSTATE_USERVISIBLE) then
  begin


  end;
end;


procedure WB_SetTextAreaValue(Document: IDispatch; sName, sValue: string; Options: TFindOptions);
var
  Doc2: IHTMLDocument2;
  index: Integer;
  field: IHTMLElement;
  textarea: IHTMLTextAreaElement;
begin
   if Supports(Document, IHtmlDocument2, Doc2) then
    for index := 0 to (Doc2.all.length) - 1 do
    begin
      field := Doc2.all.Item(index, '') as IHTMLElement;
      if Assigned(field) then
      begin
        if field.tagName = 'TEXTAREA' then
        begin
          textarea := field as IHTMLTextAreaElement;
          if Assigned(textarea) then
          begin
            if ((frWholeWord in Options) and (sName = textarea.Name))
              or ((Options = []) and (AnsiPos(sName, textarea.Name) <> 0)) then
              textarea.Value := sValue;
          end;
        end;
      end;
    end;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  WB_SetTextAreaValue(EmbeddedWB1.Document, 'comments', 'Line1'#13#10'Line2', []);
end;

end.

