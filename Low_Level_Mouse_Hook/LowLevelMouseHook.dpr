library LowLevelMouseHook;

uses
  Windows,
  Messages;

const
  WH_MOUSE_LL = 14;
  MMFName: PChar = 'MMF';

type
  PGlobalDLLData = ^TGlobalDLLData;
  TGlobalDLLData = packed record
    WndHook: HWND;
    Wnd: HWND;
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
  GlobalData: PGlobalDLLData;
  MMFHandle: THandle;
  Filters: TMouseHookFilters;
  MWM_LBUTTONDOWN: Cardinal;
  MWM_LBUTTONUP: Cardinal;
  MWM_MBUTTONDOWN: Cardinal;
  MWM_MBUTTONUP: Cardinal;
  MWM_RBUTTONDOWN: Cardinal;
  MWM_RBUTTONUP: Cardinal;
  MWM_MOUSEWHEEL: Cardinal;
  MWM_MOUSEMOVE: Cardinal;

function LowLevelMouseProc(Code: Integer; wParam: DWORD; lParam: DWORD): Longint; stdcall;
begin
  if (Code = HC_ACTION) then
  begin
    if (wParam =  WM_LBUTTONDOWN) then
    begin
      SendMessage(GlobalData.Wnd, MWM_LBUTTONDOWN, 0, 0);
      if Filters.BlockLeftButton = True then
        Result := - 1
      else
        Result := CallNextHookEx(GlobalData^.WndHook, Code, wParam, lParam);
    end else
    if (wParam =  WM_LBUTTONUP) then
    begin
      SendMessage(GlobalData.Wnd, MWM_LBUTTONUP, 0, 0);
      if Filters.BlockLeftButton = True then
        Result := - 1
      else
        Result := CallNextHookEx(GlobalData^.WndHook, Code, wParam, lParam);
    end else
    if (wParam =  WM_MBUTTONDOWN) then
    begin
      SendMessage(GlobalData.Wnd, MWM_MBUTTONDOWN, 0, 0);
      if Filters.BlockMiddleButton = True then
        Result := - 1
      else
        Result := CallNextHookEx(GlobalData^.WndHook, Code, wParam, lParam);
    end else
    if (wParam =  WM_MBUTTONUP) then
    begin
      SendMessage(GlobalData.Wnd, MWM_MBUTTONUP, 0, 0);
      if Filters.BlockMiddleButton = True then
        Result := - 1
      else
        Result := CallNextHookEx(GlobalData^.WndHook, Code, wParam, lParam);
    end else
    if (wParam =  WM_RBUTTONDOWN) then
    begin
      SendMessage(GlobalData.Wnd, MWM_RBUTTONDOWN, 0, 0);
      if Filters.BlockRightButton = True then
        Result := - 1
      else
        Result := CallNextHookEx(GlobalData^.WndHook, Code, wParam, lParam);
    end else
    if (wParam =  WM_RBUTTONUP) then
    begin
      SendMessage(GlobalData.Wnd, MWM_RBUTTONUP, 0, 0);
      if Filters.BlockRightButton = True then
        Result := - 1
      else
        Result := CallNextHookEx(GlobalData^.WndHook, Code, wParam, lParam);
    end else
    if (wParam =  WM_MOUSEWHEEL) then
    begin
      SendMessage(GlobalData.Wnd, MWM_MOUSEWHEEL, 0, 0);
      if Filters.BlockWheel = True then
        Result := - 1
      else
        Result := CallNextHookEx(GlobalData^.WndHook, Code, wParam, lParam);
    end else
    if (wParam =  WM_MOUSEMOVE) then
    begin
      SendMessage(GlobalData.Wnd, MWM_MOUSEMOVE, 0, 0);
      if Filters.BlockMouseMove = True then
        Result := - 1
      else
        Result := CallNextHookEx(GlobalData^.WndHook, Code, wParam, lParam);
    end
    else
      Result := CallNextHookEx(GlobalData^.WndHook, Code, wParam, lParam);
  end;
end;

function StartMouseHook(State: Boolean; Wnd: HWND): Boolean; export; stdcall;
begin
  Result := False;
  if State = True then
  begin
    GlobalData^.WndHook := SetWindowsHookEx(WH_MOUSE_LL, @LowLevelMouseProc, hInstance, 0);
    GlobalData^.Wnd := Wnd;
    if GlobalData^.WndHook <> 0 then
      Result := True;
  end
  else
  begin
    UnhookWindowsHookEx(GlobalData^.WndHook);
    Result := False;
  end;
end;

function StopMouseHook(): Boolean; export; stdcall;
begin
  UnhookWindowsHookEx(GlobalData^.WndHook);
  if GlobalData^.WndHook = 0 then
    Result := False
  else
   Result := True;
end;

function UpdateMouseHook(HookFilters: TMouseHookFilters): Boolean; export; stdcall;
begin
  Filters := HookFilters;
end;

procedure OpenGlobalData();
begin
  MWM_LBUTTONDOWN := RegisterWindowMessage('MWM_LBUTTONDOWN');
  MWM_LBUTTONUP := RegisterWindowMessage('MWM_LBUTTONUP');
  MWM_MBUTTONDOWN := RegisterWindowMessage('MWM_MBUTTONDOWN');
  MWM_MBUTTONUP := RegisterWindowMessage('MWM_MBUTTONUP');
  MWM_RBUTTONDOWN := RegisterWindowMessage('MWM_RBUTTONDOWN');
  MWM_RBUTTONUP := RegisterWindowMessage('MWM_RBUTTONUP');
  MWM_MOUSEWHEEL := RegisterWindowMessage('MWM_MOUSEWHEEL');
  MWM_MOUSEMOVE := RegisterWindowMessage('MWM_MOUSEMOVE');
  MMFHandle := CreateFileMapping(INVALID_HANDLE_VALUE, nil, PAGE_READWRITE, 0, SizeOf(TGlobalDLLData), MMFName);
  GlobalData := MapViewOfFile(MMFHandle, FILE_MAP_ALL_ACCESS, 0, 0, SizeOf(TGlobalDLLData));
  if GlobalData = nil then
    CloseHandle(MMFHandle);
end;

procedure CloseGlobalData();
begin
  UnmapViewOfFile(GlobalData);
  CloseHandle(MMFHandle);
end;

procedure DLLEntryPoint(Reason: DWORD);
begin
  case Reason of
    DLL_PROCESS_ATTACH: OpenGlobalData;
    DLL_PROCESS_DETACH: CloseGlobalData;
  end;
end;

exports StartMouseHook, StopMouseHook, UpdateMouseHook;

begin
  DLLEntryPoint(DLL_PROCESS_ATTACH);
end.
