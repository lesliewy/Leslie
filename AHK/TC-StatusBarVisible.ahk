$+Q::                                                   ;define hotkey Shift+Q
String=                                                 ;initialize String variable
IfWinActive, ahk_class TTOTAL_CMD                       ;if TC is active start quicksearching,
                                                        ;otherwise send Shift+Q
{
  Loop                                                  ;start loop
  {
    WinGetPos, , Y, , Height, A                         ;get TC-window Y-dimensions
    PostMessage, 1075, 2915, , , A                      ;call quicksearch box
    WinWait, ahk_class TQUICKSEARCH                     ;wait for quicksearch box to appear
    WinMove, A, , , Y+Height                            ;move quicksearch box down
    ControlSetText, TTabEdit1, %String%                 ;reload content of quicksearch box
    ControlSend, TTabEdit1, {END}                       ;move cursor to the end of quicksearch box
    Input, Keypress, L1 I M V, {ESC}{LButton}{RButton}  ;wait for input
    If Errorlevel=EndKey:Escape                         ;when ESC has been pressed exit loop
    {
      ControlSend, TTabEdit1, {ESC}
      Break
    }
    ControlGetText, String, TTabEdit1                   ;get content of quicksearch box
    Send, {ESC}                                         ;close quicksearch box
  }
}
Else Send, {SHIFT}Q
Return


