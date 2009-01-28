//***********************************************************
//                       EwbControl component               *
//                                                          *
//                       For Delphi 5 to 2009               *
//                     Freeware Component                   *
//                            by                            *
//                          (smot)                          *
//                                                          *
//  Documentation and updated versions:                     *
//                                                          *
//               http://www.bsalsa.com                      *
//***********************************************************
{*******************************************************************************}
{LICENSE:
THIS SOFTWARE IS PROVIDED TO YOU "AS IS" WITHOUT WARRANTY OF ANY KIND,
EITHER EXPRESSED OR IMPLIED INCLUDING BUT NOT LIMITED TO THE APPLIED
WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
YOU ASSUME THE ENTIRE RISK AS TO THE ACCURACY AND THE USE OF THE SOFTWARE
AND ALL OTHER RISK ARISING OUT OF THE USE OR PERFORMANCE OF THIS SOFTWARE
AND DOCUMENTATION. [YOUR NAME] DOES NOT WARRANT THAT THE SOFTWARE IS ERROR-FREE
OR WILL OPERATE WITHOUT INTERRUPTION. THE SOFTWARE IS NOT DESIGNED, INTENDED
OR LICENSED FOR USE IN HAZARDOUS ENVIRONMENTS REQUIRING FAIL-SAFE CONTROLS,
INCLUDING WITHOUT LIMITATION, THE DESIGN, CONSTRUCTION, MAINTENANCE OR
OPERATION OF NUCLEAR FACILITIES, AIRCRAFT NAVIGATION OR COMMUNICATION SYSTEMS,
AIR TRAFFIC CONTROL, AND LIFE SUPPORT OR WEAPONS SYSTEMS. VSOFT SPECIFICALLY
DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTY OF FITNESS FOR SUCH PURPOSE.

You may use, change or modify the component under 4 conditions:
1. In your website, add a link to "http://www.bsalsa.com"
2. In your application, add credits to "Embedded Web Browser"
3. Mail me  (bsalsa@bsalsa.com) any code change in the unit
   for the benefit of the other users.
4. Please, consider donation in our web site!
{*******************************************************************************}

unit EwbControlComponent;

interface

uses
  Windows, Messages, SysUtils, Classes, Forms, EWBMouseHook;

  {============================================================================}
  // Mouse WheelFix
  {============================================================================}
type
  TMouseWheelFix = class(TPersistent)
  private
    FActive: Boolean;
    FActiveFormOnly: Boolean;
    FEWBMouseHook: TEWBMouseHook;
    FDesignMode: Boolean;
    procedure SetActive(const Value: Boolean);
    procedure SetActiveFormOnly(const Value: Boolean);
  public
    OnMouseWheel: TMouseWheelEvent;
  published
    property Active: Boolean read FActive write SetActive default True;
    property ActiveFormOnly: Boolean read FActiveFormOnly write SetActiveFormOnly default False;
  end;

  {============================================================================}
  // FocusControl
  {============================================================================}
type
  TFocusControl = class(TPersistent)
  private
    FActive: Boolean;
    FDesignMode: Boolean;
    procedure SetActive(const Value: Boolean);
  published
    property Active: Boolean read FActive write SetActive default True;
  end;

  {============================================================================}
  // OnMessage Handler
  {============================================================================}
{
type
  TMessageHandler = class(TPersistent)
  private
    FActive: Boolean;
    FDesignMode: Boolean;
    FOnMessage: TMessageEvent;
    procedure SetActive(const Value: Boolean);
  published
    property Active: Boolean read FActive write SetActive default True;
  end;
}

type
  TEwbControl = class(TComponent)
  private
    { Private declarations }
    FMouseWheelFix: TMouseWheelFix;
    FFocusControl: TFocusControl;
    //  FMessageHandler: TMessageHandler;
    //  FOnMessage: TMessageEvent;
    FOnMouseWheel: TMouseWheelEvent;
    FDesignMode: Boolean;
    function CheckOneInstance(AOwner: TComponent): Boolean;
    //  procedure DoMessage(var Msg: TMsg; var Handled: Boolean);
  protected
    { Protected declarations }
    //  procedure ProcessWBEvents(var Msg: TMsg; var Handled: Boolean);
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
  published
    { Published declarations }
    property MouseWheelFix: TMouseWheelFix read FMouseWheelFix write FMouseWheelFix;
    property FocusControl: TFocusControl read FFocusControl write FFocusControl;
   // property MessageHandler: TMessageHandler read FMessageHandler write FMessageHandler;
   // property OnMessage: TMessageEvent read FOnMessage write FOnMessage;
    property OnMouseWheel: TMouseWheelEvent read FOnMouseWheel write FOnMouseWheel;
  end;


implementation

uses
  EwbFocusControl;

procedure TFocusControl.SetActive(const Value: Boolean);
begin
  FActive := Value;
  if not FDesignMode then
    TEWBFocusControl.Activate(Value);
end;

{procedure TMessageHandler.SetActive(const Value: Boolean);
begin
  FActive := Value;
  if not FDesignMode then
  begin
    if FActive then
      Application.OnMessage := FOnMessage;
  end;
end; }


procedure TMouseWheelFix.SetActiveFormOnly(const Value: Boolean);
begin
  FActiveFormOnly := Value;
  if Assigned(FEWBMouseHook) then
    FEWBMouseHook.FActiveFormOnly := FActiveFormOnly;
end;

procedure TMouseWheelFix.SetActive(const Value: Boolean);
begin
  FActive := Value;
  if not FDesignMode then
    if Value then
    begin
      if FEWBMouseHook = nil then
      begin
        FEWBMouseHook := TEWBMouseHook.Create;
        FEWBMouseHook.OnMouseWheel := OnMouseWheel;
        FEWBMouseHook.FActiveFormOnly := FActiveFormOnly;
        FEWBMouseHook.Activate;
      end;
    end else
    begin
      if Assigned(FEWBMouseHook) then
      begin
        FEWBMouseHook.Deactivate;
        FreeAndNil(FEWBMouseHook);
      end;
    end;
end;

function TEwbControl.CheckOneInstance(AOwner: TComponent): Boolean;
var
  EwbControlCount, i: Integer;
begin
  EwbControlCount := 0;
  for i := 0 to Pred(Owner.ComponentCount) do
    if (Owner.Components[i] is TEwbControl) then Inc(EwbControlCount);
  Result := not (EwbControlCount > 1);
end;

procedure TEwbControl.Loaded;
begin
  inherited Loaded;
  if Assigned(FMouseWheelFix) then
    FMouseWheelFix.OnMouseWheel := OnMouseWheel;
{  if Assigned(FMessageHandler) then
    FMessageHandler.FOnMessage := DoMessage; }
end;

constructor TEwbControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FDesignMode := (csDesigning in ComponentState);

  if not FDesignMode then
    if (AOwner <> nil) and not CheckOneInstance(AOwner) then
      raise Exception.Create('Only one instance of TEwbControl is allowed.');

  FMouseWheelFix := TMouseWheelFix.Create;
  FMouseWheelFix.FDesignMode := FDesignMode;
  FMouseWheelFix.FActive := True;

  FFocusControl := TFocusControl.Create;
  FFocusControl.FDesignMode := FDesignMode;
  FFocusControl.FActive := True;

{  FMessageHandler := TMessageHandler.Create;
  FMessageHandler.FDesignMode := FDesignMode;
  FMessageHandler.FOnMessage := DoMessage;

  FMessageHandler.FActive := True; }
end;

{
procedure TEwbControl.ProcessWBEvents(var Msg: TMsg; var Handled: Boolean);
begin
end;


procedure TEwbControl.DoMessage(var Msg: TMsg; var Handled: Boolean);
begin
  if Assigned(FOnMessage) then
  begin
    FOnMessage(Msg, Handled);
  end;
  ProcessWBEvents(Msg, Handled);
end;
}

destructor TEwbControl.Destroy;
begin
  if not (csDesigning in ComponentState) then
  begin
  {  if Assigned(FMessageHandler) then
    begin
      FMessageHandler.Active := False;
      Application.OnMessage := nil;
      FreeAndNil(FMessageHandler);
    end;  }
    if Assigned(FMouseWheelFix) then
    begin
      FMouseWheelFix.Active := False;
      FreeAndNil(FMouseWheelFix);
    end;
    if Assigned(FFocusControl) then
    begin
      FFocusControl.Active := False;
      FreeAndNil(FFocusControl);
    end;
  end;
  inherited Destroy;
end;

end.

