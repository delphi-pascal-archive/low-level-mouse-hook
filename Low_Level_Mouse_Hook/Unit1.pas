{Автор Зорков Игорь - zorkovigor@mail.ru
Спасибо Мастерам Delphi за их сайт - http://www.delphimaster.ru,
Пожалуй лучший (на мой взгляд) сайт на английском языке посвящённый Delphi - http://www.torry.net,
Все исходники Delphi здесь - http://www.delphisources.ru/index.html}
unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    gbHookStatus: TGroupBox;
    btnStopHook: TButton;
    btnStartHook: TButton;
    btnUpdateHook: TButton;
    gbFilterOptions: TGroupBox;
    cbBlockLeftButton: TCheckBox;
    cbBlockMiddleButton: TCheckBox;
    cbBlockRightButton: TCheckBox;
    cbBlockMouseMove: TCheckBox;
    cbBlockWheel: TCheckBox;
    gbStayOnTop: TGroupBox;
    cbStayOnTop: TCheckBox;
    cbLeftMouseClick: TCheckBox;
    cbMiddleMouseClick: TCheckBox;
    cbRightMouseClick: TCheckBox;
    procedure btnStartHookClick(Sender: TObject);
    procedure btnUpdateHookClick(Sender: TObject);
    procedure btnStopHookClick(Sender: TObject);
    procedure cbStayOnTopClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  protected
    procedure WndProc(var Msg: TMessage); override;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure UpdateHook();
  end;

type
 TMouseHookFilters = record
   BlockMouseMove: boolean;
   BlockLeftButton: boolean;
   BlockRightButton: boolean;
   BlockMiddleButton: boolean;
   BlockWheel: boolean;
 end;

var
  Form1: TForm1;
  HookEnable: Boolean = False;
  HookFilters: TMouseHookFilters;
  MWM_LBUTTONDOWN: Cardinal;
  MWM_LBUTTONUP: Cardinal;
  MWM_MBUTTONDOWN: Cardinal;
  MWM_MBUTTONUP: Cardinal;
  MWM_RBUTTONDOWN: Cardinal;
  MWM_RBUTTONUP: Cardinal;
  MWM_MOUSEWHEEL: Cardinal;
  MWM_MOUSEMOVE: Cardinal;


  {Если в папке отсутствует LowLevelMouseHook.dll откройте и скомпилируйте проект LowLevelMouseHook
  (File->Open Project...->LowLevelMouseHook.dpr)
  Project->Compile LowLevelMouseHook}
  function StartMouseHook(State: Boolean; Wnd: HWND): Boolean; stdcall; external 'LowLevelMouseHook.dll';
  function StopMouseHook(): Boolean; stdcall; external 'LowLevelMouseHook.dll';
  function UpdateMouseHook(HookFilters: TMouseHookFilters): Boolean; stdcall; external 'LowLevelMouseHook.dll';

implementation

{$R *.dfm}

procedure TForm1.WndProc(var Msg: TMessage);
begin
  inherited;
  if (Msg.Msg = MWM_LBUTTONDOWN) then
  begin
    cbLeftMouseClick.Checked := true
  end;
  if (Msg.Msg = MWM_LBUTTONUP) then
  begin
    cbLeftMouseClick.Checked := false;
  end;
  if (Msg.Msg = MWM_MBUTTONDOWN) then
  begin
    cbMiddleMouseClick.Checked := true
  end;
  if (Msg.Msg = MWM_MBUTTONUP) then
  begin
    cbMiddleMouseClick.Checked := false;
  end;
  if (Msg.Msg = MWM_RBUTTONDOWN) then
  begin
    cbRightMouseClick.Checked := true
  end;
  if (Msg.Msg = MWM_RBUTTONUP) then
  begin
    cbRightMouseClick.Checked := false;
  end;
end;

procedure TForm1.UpdateHook();
begin
  if cbBlockLeftButton.Checked then
    HookFilters.BlockLeftButton := True
  else
    HookFilters.BlockLeftButton := False;
  if cbBlockMiddleButton.Checked then
    HookFilters.BlockMiddleButton := True
  else
    HookFilters.BlockMiddleButton := False;
  if cbBlockRightButton.Checked then
    HookFilters.BlockRightButton := True
  else
    HookFilters.BlockRightButton := False;
  if cbBlockWheel.Checked then
    HookFilters.BlockWheel := True
  else
    HookFilters.BlockWheel := False;
  if cbBlockMouseMove.Checked then
    HookFilters.BlockMouseMove := True
  else
    HookFilters.BlockMouseMove := False;
  UpdateMouseHook(HookFilters);
end;

procedure TForm1.btnStartHookClick(Sender: TObject);
begin
  if StartMouseHook(True, Handle) = True then
  begin
    HookEnable := True;
    btnStartHook.Enabled := False;
    btnStopHook.Enabled := True;
    btnUpdateHook.Enabled := True;
    UpdateHook();
  end else
  //
end;

procedure TForm1.btnStopHookClick(Sender: TObject);
begin
  if StopMouseHook = True then
  begin
    HookEnable := False;
    btnStopHook.Enabled := False;
    btnUpdateHook.Enabled := False;
    btnStartHook.Enabled := True;
  end else
  //
end;

procedure TForm1.btnUpdateHookClick(Sender: TObject);
begin
  UpdateHook();
end;

procedure TForm1.cbStayOnTopClick(Sender: TObject);
begin
  if cbStayOnTop.Checked then
    SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE)
  else
    SetWindowPos(Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if HookEnable <> False then
    StopMouseHook;
end;

initialization
  MWM_LBUTTONDOWN := RegisterWindowMessage('MWM_LBUTTONDOWN');
  MWM_LBUTTONUP := RegisterWindowMessage('MWM_LBUTTONUP');
  MWM_MBUTTONDOWN := RegisterWindowMessage('MWM_MBUTTONDOWN');
  MWM_MBUTTONUP := RegisterWindowMessage('MWM_MBUTTONUP');
  MWM_RBUTTONDOWN := RegisterWindowMessage('MWM_RBUTTONDOWN');
  MWM_RBUTTONUP := RegisterWindowMessage('MWM_RBUTTONUP');
  MWM_MOUSEWHEEL := RegisterWindowMessage('MWM_MOUSEWHEEL');
  MWM_MOUSEMOVE := RegisterWindowMessage('MWM_MOUSEMOVE');
end.
