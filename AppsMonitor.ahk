;
; This script is saving a part of a given window as an image (.png) file regularly (every 10 seconds).
; It uses the GDI+ standard library 1.45 by tic which can be found here: https://autohotkey.com/board/topic/29449-gdi-standard-library-145-by-tic
;
; In order to work the script needs a file named Apps.ini which contains details about the apps to be monitored.
; Each app is presented as a single section in the file. The numbers for the rectangle to be saved are in percents.
;
; Idea: nicolas-zozol
; Implementation: BoyanLK
;

#SingleInstance force
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2

#include Gdip_All.ahk

OnExit, CloseScript

pToken := Gdip_Startup()

; Settings
IniRead, iCount, Settings.ini, Main, ImagesCount, 1

sPath := A_YYYY "-" A_MM "-" A_DD

; Read the sections (apps) names from the .ini file
IniRead, AppsList, Apps.ini

;MsgBox, %AppsList%
	
loop, parse, AppsList, `r`n
{
	sSection := A_LoopField
	IniRead, sTitleMask, Apps.ini, %sSection%, TitleMask, %sSection%
	
	GroupAdd, grpApps, %sTitleMask%
	
	DirName := sPath "\" sSection
	;MsgBox, %sSection%`n%DirName%
	
	IfNotExist, %DirName%
		FileCreateDir, %DirName%
}

; Main
loop
{
	WinWait, ahk_group grpApps
	
	WinGet, WinList, List, ahk_group grpApps

	loop, %WinList%
	{
		id := "WinList" A_Index
		WinGetTitle, sTitle, % "ahk_id " %id%
		WinGetPos, x, y, w, h, % "ahk_id " %id%
		
		if (h < 30)
			continue
		
		; Read app data from Apps.ini file
		sSection := GetWindowSection(sTitle)
		IniRead, iRectX, Apps.ini, %sSection%, RectX, 0
		IniRead, iRectY, Apps.ini, %sSection%, RectY, 0
		IniRead, iRectW, Apps.ini, %sSection%, RectW, 100
		IniRead, iRectH, Apps.ini, %sSection%, RectH, 100
		
		;MsgBox, % id "`n" %id% "`n" sTitle "`n" x "`n" y "`n" w "`n" h "`n--------------------`n" iRectX "`n" iRectY "`n" iRectW "`n" iRectH
		
		; Capture image from the found window
		pWinBitmap := Gdip_BitmapFromHWND(%id%)
		
		; Create a new image
		pNewBitmap := Gdip_CreateBitmap(iRectW*w//100, iRectH*h//100)
		pGraphics := Gdip_GraphicsFromImage(pNewBitmap)
		
		Gdip_DrawImage(pGraphics, pWinBitmap, 0, 0, iRectW*w//100, iRectH*h//100, iRectX*w//100, iRectY*h//100, iRectW*w//100, iRectH*h//100)
		Gdip_SaveBitmapToFile(pNewBitmap, sPath "\" sSection "\" iCount "_" RandomText() ".png")
		
		Gdip_GraphicsClear(pGraphics)
		Gdip_DisposeImage(pNewBitmap)
		Gdip_DisposeImage(pWinBitmap)
		
		iCount++
	}
	
	Sleep, 10000
}

return

CloseScript:
	IniWrite, %iCount%, Settings.ini, Main, ImagesCount
	Gdip_Shutdown(pToken)
	ExitApp

; Generates a random sequence of lowercase latin leters
RandomText(iSize = 10)
{
	sText := ""
	
	loop, %iSize%
	{
		random, x, 97, 122
		sText .= Chr(x)
	}
	
	return sText
}

; Searches for an app name in a given window's title
GetWindowSection(sTitle)
{
	global AppsList
	
	loop, parse, AppsList, `r`n
	{
		if (InStr(sTitle, A_LoopField))
			return A_LoopField
	}
	
	return ""
}