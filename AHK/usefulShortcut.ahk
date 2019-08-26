#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

!1::            ; 开机必备
;Run f:\shortcut\TC.lnk
;WinGetActiveTitle, Title
;MsgBox, The active window is "%Title%".


Run f:\shortcut\TC.lnk
Sleep, 300
IfWinExist, Total Commander Portable
    WinActivate ; use the window found above
    Send {Enter} 
IfWinExist, Total Commander
    WinActivate ; use the window found above
    Sleep 500
    Send #{Up}
Run f:\shortcut\chrome.lnk
Run Taskmgr.exe, , max 
IfWinExist,任务管理器               ; 不明白为什么无法最大化.
    ;MsgBox, leslie
    WinActivate ; use the window found above
    Sleep 2000
    Send #{Up}
    ;MsgBox, leslie
return

!3::            ; 吾股丰登
Run http://v.pptv.com/page/t2XOTLQaiasgrqTU.html?rcc_id=baiduchuisou   
return