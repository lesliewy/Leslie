; 该脚本使用 HM VNISEdit 脚本编辑器向导产生

; 遗留问题:  没加右键菜单, 这个比较麻烦. 可以参考7-zip.
; 安装程序初始定义常量
!define PRODUCT_NAME "WinRAR"
!define PRODUCT_VERSION "4.11"
!define PRODUCT_PUBLISHER "leslie"
!define PRODUCT_WEB_SITE "none"
;会写入注册表: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\WinRAR_sC.exe:  增加一个默认,值为C:\Program Files\WinRAR_sC.exe
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\WinRAR_sC.exe"
!define PRODUCT_CONTEXTMENUHANDLERS_KEY "SOFTWARE\Classes\*\shellex\CONTEXTMENUHANDLERS\WinRAR"
; 文件关联
!define PRODUCT_CLASSES "SOFTWARE\Classes"
;会写入注册表: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\WinRAR-Leslie 下面会增加几个值: DisplayIcon,DisplayName,DisplayVersion,Publisher,UninstallString,URLInfoAbout.
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

SetCompressor lzma

; ------ MUI 现代界面定义 (1.67 版本以上兼容) ------
; 文件位于: c:\Program Files\NSIS\Include\MUI.nsh
!include "MUI.nsh"

; MUI 预定义常量
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"
; 安装完成后说明. 如果选择,会直接打开 MUI_FINISHPAGE_SHOWREADME 定义的文件.
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\License.txt"
!define MUI_FINISHPAGE_SHOWREADME_TEXT "查看 安装说明"

;下面是安装的过程,顺序不能乱.
; 欢迎页面
!insertmacro MUI_PAGE_WELCOME
; 许可协议页面
!insertmacro MUI_PAGE_LICENSE "License.txt"
; 组件选择页面
!insertmacro MUI_PAGE_COMPONENTS
; 安装目录选择页面
!insertmacro MUI_PAGE_DIRECTORY
; 安装过程页面
!insertmacro MUI_PAGE_INSTFILES
; 安装完成页面
!insertmacro MUI_PAGE_FINISH
!define MUI_FINISHPAGE_RUN "$PROGRAMFILES\WinRAR.exe"

;软件说明
!define MUI_WELCOMEPAGE_TEXT "　　软件作者：leslie\r\n\r\n　　官方网址：www.flighty.cn\r\n\r\n　　$_CLICK"
; 安装卸载过程页面
!insertmacro MUI_UNPAGE_INSTFILES

; 安装界面包含的语言设置
!insertmacro MUI_LANGUAGE "SimpChinese"

; 安装预释放文件
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI 现代界面定义结束 ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
; 输出的文件名.
OutFile "WinRARPortable.exe"
; 默认的安装路径.
InstallDir "$PROGRAMFILES\WinRARPortable"
; 设置key.
InstallDirRegKey HKLM "${PRODUCT_UNINST_KEY}" "UninstallString"
; 显示安装明细.
ShowInstDetails show
ShowUnInstDetails show
; 安装过程中下方的隐形文件.
BrandingText "by Leslie_wy"

; 第一个安装组件.
Section "main" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  ; 需要先将exe文件解压到目录WinRAR_sC
  File /r WinRAR_sC\*
SectionEnd

; $INSTDIR  这个变量是用户选择的安装路径,安装时才能确定.
Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
;  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_CONTEXTMENUHANDLERS_KEY}" "" "B41DB860-8EE4-11D2-9906-E49FADC173CA"
;  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_CLASSES}\.7z" "" "WinRAR"
;  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_CLASSES}\.tar" "" "WinRAR"
;  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_CLASSES}\.zip" "" "WinRAR"
;  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_CLASSES}\.rar" "" "WinRAR"
;  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_CLASSES}\CLSID\{B41DB860-8EE4-11D2-9906-E49FADC173CA}\InProcServer32" "" "$INSTDIR\rarext.dll"
;  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_CLASSES}\CLSID\{B41DB860-8EE4-11D2-9906-E49FADC173CA}\InProcServer32" "ThreadingModel" "Apartment"
;  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_CLASSES}\CLSID\{B41DB860-8EE4-11D2-9906-E49FADC173CA}\" "" "WinRAR"

  
;  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$PROGRAMFILES\WinRAR_sC.exe"
;  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
;  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
;  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$PROGRAMFILES\WinRAR_sC.exe"
;  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
;  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
;  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

;右健菜单
section Registry
;WriteRegStr "HKLM" "SOFTWARE\Thunder Network\ThunderOem\thunder_backwnd" "Path" "$INSTDIR\Thunder.exe"
;WriteRegStr "HKLM" "SOFTWARE\Thunder Network\ThunderOem\thunder_backwnd" "Version" "5.7.2.389"
WriteRegStr "HKCU" "Software\Microsoft\Internet Explorer\MenuExt\使用迅雷下载全部链接" "" "$INSTDIR\Program\GetAllUrl.htm"
;WriteRegDWORD "HKCU" "Software\Microsoft\Internet Explorer\MenuExt\使用迅雷下载全部链接" "Contexts" "243"
;WriteRegStr "HKCU" "Software\Microsoft\Internet Explorer\MenuExt\使用迅雷下载" "" "$INSTDIR\Program\GetUrl.htm"
;WriteRegDWORD "HKCU" "Software\Microsoft\Internet Explorer\MenuExt\使用迅雷下载" "Contexts" "34"
SectionEnd



#-- 根据 NSIS 脚本编辑规则，所有 Function 区段必须放置在 Section 区段之后编写，以避免安装程序出现未可预知的问题。--#

; 区段组件描述
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC01} ""
!insertmacro MUI_FUNCTION_DESCRIPTION_END

/******************************
 *  以下是安装程序的卸载部分  *
 ******************************/
; 点击uninst.exe后,执行部分.
Section Uninstall
;  Delete "$INSTDIR\uninst.exe"
;  Delete "$PROGRAMFILES\WinRAR_sC.exe"
	MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "instdir:$INSTDIR" IDYES +1
	; 删除安装目录下的所有文件,包括目录.
  RMDir /r "$INSTDIR"

;  DeleteRegKey "${PRODUCT_CLASSES}\.7z" "${PRODUCT_CLASSES}\.tar" "${PRODUCT_CLASSES}\.zip" "${PRODUCT_CLASSES}\.rar" "${PRODUCT_CLASSES}\CLSID\{B41DB860-8EE4-11D2-9906-E49FADC173CA}" "${PRODUCT_CONTEXTMENUHANDLERS_KEY}"
;  DeleteRegKey "${PRODUCT_UNINST_ROOT_KEY}" "${PRODUCT_CLASSES}\.rar"
;  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
;  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd

#-- 根据 NSIS 脚本编辑规则，所有 Function 区段必须放置在 Section 区段之后编写，以避免安装程序出现未可预知的问题。--#

; 上面生成的uninst.exe点击后, 先执行这里.
Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "您确实要完全移除 $(^Name) ，及其所有的组件？" IDYES +2
  Abort
FunctionEnd

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) 已成功地从您的计算机移除。"
FunctionEnd
