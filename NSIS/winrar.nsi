; �ýű�ʹ�� HM VNISEdit �ű��༭���򵼲���

; ��������:  û���Ҽ��˵�, ����Ƚ��鷳. ���Բο�7-zip.
; ��װ�����ʼ���峣��
!define PRODUCT_NAME "WinRAR"
!define PRODUCT_VERSION "4.11"
!define PRODUCT_PUBLISHER "leslie"
!define PRODUCT_WEB_SITE "none"
;��д��ע���: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\WinRAR_sC.exe:  ����һ��Ĭ��,ֵΪC:\Program Files\WinRAR_sC.exe
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\WinRAR_sC.exe"
!define PRODUCT_CONTEXTMENUHANDLERS_KEY "SOFTWARE\Classes\*\shellex\CONTEXTMENUHANDLERS\WinRAR"
; �ļ�����
!define PRODUCT_CLASSES "SOFTWARE\Classes"
;��д��ע���: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\WinRAR-Leslie ��������Ӽ���ֵ: DisplayIcon,DisplayName,DisplayVersion,Publisher,UninstallString,URLInfoAbout.
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

SetCompressor lzma

; ------ MUI �ִ����涨�� (1.67 �汾���ϼ���) ------
; �ļ�λ��: c:\Program Files\NSIS\Include\MUI.nsh
!include "MUI.nsh"

; MUI Ԥ���峣��
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"
; ��װ��ɺ�˵��. ���ѡ��,��ֱ�Ӵ� MUI_FINISHPAGE_SHOWREADME ������ļ�.
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\License.txt"
!define MUI_FINISHPAGE_SHOWREADME_TEXT "�鿴 ��װ˵��"

;�����ǰ�װ�Ĺ���,˳������.
; ��ӭҳ��
!insertmacro MUI_PAGE_WELCOME
; ���Э��ҳ��
!insertmacro MUI_PAGE_LICENSE "License.txt"
; ���ѡ��ҳ��
!insertmacro MUI_PAGE_COMPONENTS
; ��װĿ¼ѡ��ҳ��
!insertmacro MUI_PAGE_DIRECTORY
; ��װ����ҳ��
!insertmacro MUI_PAGE_INSTFILES
; ��װ���ҳ��
!insertmacro MUI_PAGE_FINISH
!define MUI_FINISHPAGE_RUN "$PROGRAMFILES\WinRAR.exe"

;���˵��
!define MUI_WELCOMEPAGE_TEXT "����������ߣ�leslie\r\n\r\n�����ٷ���ַ��www.flighty.cn\r\n\r\n����$_CLICK"
; ��װж�ع���ҳ��
!insertmacro MUI_UNPAGE_INSTFILES

; ��װ�����������������
!insertmacro MUI_LANGUAGE "SimpChinese"

; ��װԤ�ͷ��ļ�
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI �ִ����涨����� ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
; ������ļ���.
OutFile "WinRARPortable.exe"
; Ĭ�ϵİ�װ·��.
InstallDir "$PROGRAMFILES\WinRARPortable"
; ����key.
InstallDirRegKey HKLM "${PRODUCT_UNINST_KEY}" "UninstallString"
; ��ʾ��װ��ϸ.
ShowInstDetails show
ShowUnInstDetails show
; ��װ�������·��������ļ�.
BrandingText "by Leslie_wy"

; ��һ����װ���.
Section "main" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite ifnewer
  ; ��Ҫ�Ƚ�exe�ļ���ѹ��Ŀ¼WinRAR_sC
  File /r WinRAR_sC\*
SectionEnd

; $INSTDIR  ����������û�ѡ��İ�װ·��,��װʱ����ȷ��.
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

;�ҽ��˵�
section Registry
;WriteRegStr "HKLM" "SOFTWARE\Thunder Network\ThunderOem\thunder_backwnd" "Path" "$INSTDIR\Thunder.exe"
;WriteRegStr "HKLM" "SOFTWARE\Thunder Network\ThunderOem\thunder_backwnd" "Version" "5.7.2.389"
WriteRegStr "HKCU" "Software\Microsoft\Internet Explorer\MenuExt\ʹ��Ѹ������ȫ������" "" "$INSTDIR\Program\GetAllUrl.htm"
;WriteRegDWORD "HKCU" "Software\Microsoft\Internet Explorer\MenuExt\ʹ��Ѹ������ȫ������" "Contexts" "243"
;WriteRegStr "HKCU" "Software\Microsoft\Internet Explorer\MenuExt\ʹ��Ѹ������" "" "$INSTDIR\Program\GetUrl.htm"
;WriteRegDWORD "HKCU" "Software\Microsoft\Internet Explorer\MenuExt\ʹ��Ѹ������" "Contexts" "34"
SectionEnd



#-- ���� NSIS �ű��༭�������� Function ���α�������� Section ����֮���д���Ա��ⰲװ�������δ��Ԥ֪�����⡣--#

; �����������
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC01} ""
!insertmacro MUI_FUNCTION_DESCRIPTION_END

/******************************
 *  �����ǰ�װ�����ж�ز���  *
 ******************************/
; ���uninst.exe��,ִ�в���.
Section Uninstall
;  Delete "$INSTDIR\uninst.exe"
;  Delete "$PROGRAMFILES\WinRAR_sC.exe"
	MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "instdir:$INSTDIR" IDYES +1
	; ɾ����װĿ¼�µ������ļ�,����Ŀ¼.
  RMDir /r "$INSTDIR"

;  DeleteRegKey "${PRODUCT_CLASSES}\.7z" "${PRODUCT_CLASSES}\.tar" "${PRODUCT_CLASSES}\.zip" "${PRODUCT_CLASSES}\.rar" "${PRODUCT_CLASSES}\CLSID\{B41DB860-8EE4-11D2-9906-E49FADC173CA}" "${PRODUCT_CONTEXTMENUHANDLERS_KEY}"
;  DeleteRegKey "${PRODUCT_UNINST_ROOT_KEY}" "${PRODUCT_CLASSES}\.rar"
;  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
;  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  SetAutoClose true
SectionEnd

#-- ���� NSIS �ű��༭�������� Function ���α�������� Section ����֮���д���Ա��ⰲװ�������δ��Ԥ֪�����⡣--#

; �������ɵ�uninst.exe�����, ��ִ������.
Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "��ȷʵҪ��ȫ�Ƴ� $(^Name) ���������е������" IDYES +2
  Abort
FunctionEnd

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) �ѳɹ��ش����ļ�����Ƴ���"
FunctionEnd
