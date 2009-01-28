//****************************************************
//             Extended IEParser Demo                *
//                                                   *
//                                                   *
// By:                                               *
// Eran Bodankin (bsalsa)                            *
//  bsalsa@bsalsa.com                                *
//                                                   *
// Documentation and updated versions:               *
//               http://www.bsalsa.com               *
//****************************************************

{*******************************************************************************}
{LICENSE:
THIS SOFTWARE IS PROVIDED TO YOU "AS IS" WITHOUT WARRANTY OF ANY KIND,
EITHER EXPRESSED OR IMPLIED INCLUDING BUT NOT LIMITED TO THE APPLIED
WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A PARTICULAR PURPOSE.
YOU ASSUME THE ENTIRE RISK AS TO THE ACCURACY AND THE USE OF THE SOFTWARE
AND ALL OTHER RISK ARISING OUT OF THE USE OR PERFORMANCE OF THIS SOFTWARE
AND DocUMENTATION. [YOUR Name] DOES NOT WARRANT THAT THE SOFTWARE IS ERROR-FREE
OR WILL OPERATE WITHOUT INTERRUPTION. THE SOFTWARE IS NOT DESIGNED, INTENDED
OR LICENSED FOR USE IN HAZARDOUS ENVIRONMENTS REQUIRING FAIL-SAFE CONTROLS,
INCLUDING WITHOUT LIMITATION, THE DESIGN, CONSTRUCTION, MAINTENANCE OR
OPERATION OF NUCLEAR FACILITIES, AIRCRAFT NAVIGATION OR COMMUNICATION SystemS,
AIR TRAFFIC CONTROL, AND LIFE SUPPORT OR WEAPONS SystemS. VSOFT SPECIFICALLY
DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTY OF FITNESS FOR SUCH PURPOSE.

You may use, change or modify the component under 4 conditions:
1. In your website, add a Link to "http://www.bsalsa.com"
2. In your application, add credits to "Embedded Web Browser"
3. Mail me  (bsalsa@bsalsa.com) any code change in the unit
   for the benefit of the other users.
4. Please, consider donation in our web site!
{*******************************************************************************}


unit utParser;

interface

uses
  IEAddress, ExtCtrls, ComCtrls, UI_Less, Controls, Classes, Forms, StdCtrls,
  RichEditBrowser, EwbUrl;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Go: TButton;
    IEAddress1: TIEAddress;
    StatusBar1: TStatusBar;
    UILess1: TUILess;
    Panel2: TPanel;
    Memo3: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    memo1: TRichEditWB;
    memo2: TRichEditWB;
    procedure GoClick(Sender: TObject);
  private
    procedure UpdateControls;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.UpdateControls;
begin
  Memo1.Clear;
  Memo2.Clear;
  Memo3.Clear;
end;

procedure TForm1.GoClick(Sender: TObject);
begin
  UpdateControls;
  UILess1.Go(IEAddress1.Text);
  UILess1.GetAnchorList(memo1.lines);
  UILess1.GetImageList(memo2.lines);
  UILess1.GetLinkList(memo3.lines);
end;

end.

