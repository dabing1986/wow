; 魔兽世界 Simple Fishing Script
; By: The Alien
; Out of 100 Casts, 6 were lost, and 2 clicked premature.
; Modified script originally by Mike the Fishmonger http://www.autohotkey.com/forum/topic81808.html
; v1.0
; Instructions:
; When you first start the script there will be a box in the top left corner of your screen with a white background.
; This is your base color window. Your fishing rod, if it is hotkeyed to #1, will be cast out.
; Place your cursor over the bobber with the hook close to the red feather.
; Press and hold Ctrl+Alt+Z, the box in the top left corner will show you the color you are hovering over. Most likely it will be wrong.
; Move around the red feather while still holding Ctrl+Alt+Z until you
; find a pink/mauve/light tan color.
; If your bobber disappears, just recast it out. Once you think you have a good color,
; press Ctrl+Alt+X to test. If the mouse moves to anywhere except to near the bobber, then repeat the process.
; Once you find a working color, press F10 to start the automatic fishing. You should be able to sit back and let it do its dirty work.
; In some instances the color may need to be changed, like for when it is more daylight, or if it is darker.
; Or maybe you move to a different location and the scenery is a little different. In any case, if you need to rechoose
; your color, press F9 to reset the script. If you're done fishing for the time being, press F11 to exit.
; Notes: I have only tested this script in one location that the time of th1is writing. I have included commented out
; lines that will load images if you put the images in the same folder of this script. The 4 dot.GIF lines will show
; you the 4 corners of the scan box. The bobber.GIF will leave behind a marker where you've clicked to get a color.

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

SetWorkingDir %A_ScriptDir%

;Get window position of WoW
WinGetPos, wowX, wowY, wowW, wowH, 魔兽世界

;Create the color box
Gui, 2:Show, x100 y100 w100 h100, ColorWin
Gui, 2:Color, 0xFFFFFF
Gui 2:+AlwaysOnTop
Gui 2:-Caption +ToolWindow

;Create the scan box
Gui, Show, xCenter y200 w900 h300, FishWin

; Set the scan box to the same size and position of your WoW window
WinMove, FishWin,, 0, 0, wowW, wowH

;Creates the temp box that shows the pointer markers, only needed if you use the markers, you'll need to uncomment
;Gui, 3:Show, xCenter y200 w900 h300, TempWin
;WinMove, TempWin,, 0, 0, wowW, wowH
;Gui, 3:Color, White
;Gui, 3:Show, NA, TempWin
;Gui 3:+AlwaysOnTop
;WinSet, TransColor, White, TempWin
;Gui 3:-Caption +ToolWindow


; Get new position of scan window
WinGetPos, fishX, fishY, fishW, fishH, FishWin

;Attempt to automatically size the scan area based on your window size
TopLx := fishX + (fishW/4)
TopLy := fishY + (fishH/4)
TopRx := fishW - (fishW/4)
TopRy := fishY + (fishH/4)
BotLx := fishX + (fishW/4)
BotLy := fishH - (fishH/2.5)
BotRx := fishW - (fishW/4)
BotRy := fishH - (fishH/2.5)

; Uncomment the following 4 lines if you want to show graphics at the corners of your scan box. You will need an image
; dot.GIF in the same folder at this script. The image sizes I used were 15x15 pure green dots.
;Gui, Add, Picture, x%TopLx% y%TopLy% w15 h-1, %A_ScriptDir%\dot.GIF
;Gui, Add, Picture, x%TopRx% y%TopRy% w15 h-1, %A_ScriptDir%\dot.GIF
;Gui, Add, Picture, x%BotLx% y%BotLy% w15 h-1, %A_ScriptDir%\dot.GIF
;Gui, Add, Picture, x%BotRx% y%BotRy% w15 h-1, %A_ScriptDir%\dot.GIF

; Creates the scan area and makes the window transparent, only needed if you use the graphic corners
;Gui, Color, White
;Gui, Show, NA, FishWin
;Gui +AlwaysOnTop
;WinSet, TransColor, White, FishWin
;Gui -Caption +ToolWindow

SetKeyDelay, 60

WinActivate, 魔兽世界

thecolor = 0xFFFFFF

Sleep, 1500
send, 1


; Hotkey for the Ctrl+Alt+Z
^!z::
MouseGetPos, MouseX, MouseY
PixelGetColor, color, %MouseX%, %MouseY%

; uncomment if you use the marker image
;Gui, 3:Add, Picture, x%MouseX% y%MouseY% w15 h-1, %A_ScriptDir%\bobber.GIF

thecolor = %color%
Gui, 2:Color, %thecolor%
return

; Hotkey for the Ctrl+Alt+X
^!x::
PixelSearch, Px, Py, %TopLx%, %TopLy%, %BotRx%, %BotRy%, %thecolor%, 60, fast
Mousemove, %Px%,%Py%,50
return

F1::
mouseclick, right
sleep, 600
send, 1
sleep, 2500
gosub focal
return

; Hotkey for the Ctrl+Alt+X
F2::
PixelSearch, Px, Py, %TopLx%, %TopLy%, %BotRx%, %BotRy%, %thecolor%, 60, fast
Mousemove, %Px%,%Py%,50
return

; search bobber
focal:
PixelSearch, Px, Py, %TopLx%, %TopLy%, %BotRx%, %BotRy%, %thecolor%, 60, fast
Mousemove, %Px%,%Py%,50
sleep, 600
return

; Hotkey to reload and restart script
F9::
Reload
Sleep 4000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
IfMsgBox, Yes, Edit
return

; Hotkey to close the script and windows
F11::
Gui, Destroy
ExitApp
return

; Hotkey to start the auto fishing
F10::
Gui, 2:Destroy

; uncomment if using marker
;Gui, 3:Destroy

gosub start
return


; Uses help item for the fishing hat, needs some reworking to auto reuse it after 10 minutes, but it's 6Am and am tired lol
start:
sleep, 600


; starts fishing
gosub next
return

; activates the WoW window, casts your fishing rod [send, 1] and goes to the fishing subroutine
next:
WinActivate, 魔兽世界
send, 1
sleep, 2000
gosub fish
return

; the fishing subroutine that finds the bobber, checks the bobber pixel location, determines to retrieve bobber
fish:
sleep, 500
PixelSearch, Px, Py, %TopLx%, %TopLy%, %BotRx%, %BotRy%, %thecolor%, 60, fast
Mousemove, %Px%,%Py%,50
sleep, 4500
loop, 50 {
	PixelSearch, PxC, PyC, %TopLx%, %TopLy%, %BotRx%, %BotRy%, %thecolor%, 60, fast
	if ErrorLevel = 0
	{
		A := PyC - Py
;		MsgBox, %A%
		if A > 5
		{
			mouseclick, right
			break
		}
		else if A < -5
		{
			mouseclick, right
			break
		}
		else
		{
			sleep, 300
		}
	}
}
; just in case we missed a catch, might as well try right before we recast
mouseclick, right
sleep, 1500

; calls next routine to start a new cast
gosub next

return