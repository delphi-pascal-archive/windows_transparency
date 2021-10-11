//Автор: Strike (Борисенко Дмитрий Александрович)
//Делаем окна прозрачными - WinXp
//Из за недоработки виндовых библиотек при первом обращении к окну происходи
//перерисовка окна ...неприятно, но блин, факт
program xp;
uses
Windows,Graphics;
var
htimer:integer;
c:TCanvas;
User32: HMODULE;
SetLayeredWindowAttributes: function (hwnd: LongInt; crKey: byte;
    bAlpha: byte; dwFlags: LongInt): LongInt; stdcall;


{===============================================================}
procedure SetAlpha(hwnd: THandle; Value:Integer);
var
  old: THandle;
begin
//Тут сделаем добавим стиль
  if (User32 <> 0) and (Assigned(SetLayeredWindowAttributes))then
    begin
      old := GetWindowLongA(hwnd, GWL_EXSTYLE);
      SetWindowLongA(hwnd, GWL_EXSTYLE, old or WS_EX_LAYERED);
      SetLayeredWindowAttributes(hwnd, 0, value, LWA_ALPHA);
    end;
end;
{===============================================================}
Procedure ttimer;
var
p:Tpoint;
h:integer;
i:integer;
begin
//Таймер, который по положению курсора мыши ловит окно и тушит его
GetCursorPos(p);
h:=WindowFromPoint(p);
if IsWindow(h) then begin
SetAlpha(h, 255);
sleep(300);
for i:=255 downto 190 do begin
SetAlpha(h, i);
sleep(25);
end;
end;
end;

{===============================================================}
begin
//главный код
 User32 := LoadLibrary('USER32.DLL');
  if User32 <> 0 then
    @SetLayeredWindowAttributes := GetProcAddress(User32, 'SetLayeredWindowAttributes')
  else
    SetLayeredWindowAttributes := nil;
c:=Tcanvas.Create;
c.Handle:=GetWindowDC(GetDesktopWindow());
while true do begin
ttimer;
Sleep(100);
end;
c.Free;
  if User32 <> 0 then
    FreeLibrary(User32);
end.
