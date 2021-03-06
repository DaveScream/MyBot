; #FUNCTION# ====================================================================================================================
; Name ..........: MBRFunc, debugMBRFunctions
; Description ...: MBRFunc will open or close the MBRFunctions.dll, debugMBRFunctions will set the debug levels.
; Syntax ........:
; Parameters ....:
; Return values .:
; Author ........: Didipe (2015)
; Modified ......: Hervidero (2015)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================

Func MBRFunc($Start = True)
	Switch $Start
		Case True
			$hFuncLib = DllOpen($pFuncLib)
			If $hFuncLib = -1 Then
				Setlog("MBRfunctions.dll not found.", $COLOR_RED)
				Return False
			EndIf
			If $debugSetlog = 1 Then Setlog("MBRfunctions.dll opened.", $COLOR_PURPLE)
			;enable buttons start and search mode only if MRBfunctions.dll loaded, prevent click of buttons before dll loaded in memory
			GUICtrlSetState($btnStart, $GUI_ENABLE)
			; enable search only button when TH level variable has valid level, to avoid posts from users not pressing start first
			If $iTownHallLevel > 2 Then
				GUICtrlSetState($btnSearchMode, $GUI_ENABLE)
			EndIf
		Case False
			DllClose($hFuncLib)
			If $debugSetlog = 1 Then Setlog("MBRfunctions.dll closed.", $COLOR_PURPLE)
	EndSwitch
EndFunc   ;==>MBRFunc

Func debugMBRFunctions($debugSearchArea = 0, $debugRedArea = 0, $debugOcr = 0)

	Local $result = DllCall($hFuncLib, "str", "setGlobalVar", "int", $debugSearchArea, "int", $debugRedArea, "int", $debugOcr)
	;dll return 0 on success, -1 on error
	If IsArray($result) Then
		If $debugSetlog = 1 And $result[0] = -1 Then setlog("MBRfunctions.dll error setting Global vars.", $COLOR_PURPLE)
	Else
		If $debugSetlog = 1 Then setlog("MBRfunctions.dll not found.")
	EndIf

EndFunc   ;==>debugMBRFunctions
