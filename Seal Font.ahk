#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ExitApp
}
IfNotExist %a_scriptdir%\Font
	FileCreateDir %a_scriptdir%\Font
IfNotExist %a_scriptdir%\Images
	FileCreateDir %a_scriptdir%\Images
FileInstall,gulim.ttc,%a_scriptdir%\Font\gulim.ttc
FileInstall,small_font.jpg,%a_scriptdir%\Images\small.jpg
FileInstall,default_font.jpg,%a_scriptdir%\Images\default.jpg
RegRead,LocalAppData,HKCU,Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders, Local AppData
RegRead,LocalFont,HKCU,Software\Microsoft\Windows NT\CurrentVersion\Fonts,Gulim & GulimChe & Dotum & DotumChe (TrueType)
RegRead,Font,HKCU,Software\Microsoft\Windows NT\CurrentVersion\Fonts,Gulim
gui,add,picture,xm w150 h45,%a_scriptdir%\Images\small.jpg
gui,add,picture,x+m w150 h45,%a_scriptdir%\Images\default.jpg
if (((Font!="") and (Font!="ERROR")) or ((LocalFont!="") and (LocalFont!="ERROR"))) {
	gui,add,radio,xm vsmall w150,Small Font.
	gui,add,radio,x+m vgulim checked,Default Font (Gulim Font).
} else {
	gui,add,radio,xm vsmall w150 checked,Small Font.
	gui,add,radio,x+m vgulim,Default Font (Gulim Font).
}
gui,add,button,xm,Submit
gui,show
return

buttonSubmit:
gui,submit,nohide
if Gulim {
	FileCopy,%a_scriptdir%\Font\gulim.ttc,C:\Windows\Fonts\gulim.ttc,1
	RegWrite,REG_SZ,HKCU,Software\Microsoft\Windows NT\CurrentVersion\Fonts,Gulim,gulim.ttc
} else {
	FileDelete,%LocalAppData%\Microsoft\Windows\Fonts\gulim.ttc
	FileDelete,C:\Windows\Fonts\gulim.ttc
	RegDelete,HKCU,Software\Microsoft\Windows NT\CurrentVersion\Fonts,Gulim
	RegDelete,HKCU,Software\Microsoft\Windows NT\CurrentVersion\Fonts,Gulim & GulimChe & Dotum & DotumChe (TrueType)
}
RegRead,Font,HKCU,Software\Microsoft\Windows NT\CurrentVersion\Fonts,Gulim
if ((Font!="") and (Font!="ERROR"))
	Msgbox,Seal Online Font has changed to Default Font (Gulim).
else
	Msgbox,Seal Online Font has changed to Small Font.
guiclose:
guiescape:
exitapp