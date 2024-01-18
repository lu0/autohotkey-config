#NoTrayIcon
#SingleInstance Force
#Include %A_ScriptDir%\..\gdip-lib\Gdip_All.ahk
#Include %A_ScriptDir%\..\workspaces\utils.ahk
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Screen

; This script takes, copies to clipboard and saves a screenshot of:
;   - the current window    (super + alt + PrtScr),
;   - a selected area       (super + shift + PrtScr),
;   - or the entire screen  (super + PrtScr)
;       (for setups with 2 monitors: left - right)
;
; I also overrided the PrtScr key with the AppKey to access context menus,
; as the Thinkpad Keyboard does not have one, and PrtScr is
; placed where the AppKey is normally placed on other keyboards...
;

IMDIR := "C:\Users\" A_UserName "\Pictures\screenshots-ahk\"

; Use PrtScr as AppKey
PrintScreen::
    Send {AppsKey}
    return

; Capture the active window
#!PrintScreen::
    WinGetPos, x, y, w, h, A
    screenDim=%x%|%y%|%w%|%h%
    saveScreenshot(screenDim)
    return

; Select an area
#+Printscreen::
    setPlusCursor()
    Hotkey, LButton, captureArea, On
    return

; Capture the entire screen area
; Works on my setup (left + right monitors).j
#PrintScreen::
    SysGet, MonitorCount, MonitorCount
    SysGet, MonitorPrimary, MonitorPrimary
    monitors := []
    Loop, %MonitorCount% {
        SysGet, Mon, Monitor, %A_Index%
        monitors[A_Index] := {Left: MonLeft, Right: MonRight, Top: MonTop, Bottom: MonBottom}
    }
    minLeft := 100000, minTop := 100000
    maxRight := 0, maxBottom := 0
    For k, Mon in monitors
        if (Mon.Left < minLeft)
            minLeft := Mon.Left
        if (Mon.Top < minTop)
            minTop := Mon.Top
        if (Mon.Bottom > maxBottom)
            maxBottom := Mon.Bottom
        if (Mon.Right > maxRight)
            maxRight := Mon.Right
    x := minLeft, y := minTop
    w := Abs(x) + maxRight, h := maxBottom

    screenDim=%x%|%y%|%w%|%h%
    saveScreenshot(screenDim)
    return

captureArea:
    gui +AlwaysOnTop +Border +LastFound +ToolWindow -caption
    WinSet, Transparent, 30

    MouseGetPos, mouseX0, mouseY0
    SetTimer, overlay, 1

    KeyWait, LButton
    MouseGetPos, mouseX1, mouseY1
    SetTimer, overlay, off

    Gui, hide
    Hotkey, LButton, captureArea, Off

    x := mouseX1 > mouseX0 ? mouseX0 : mouseX1
    y := mouseY1 > mouseY0 ? mouseY0 : mouseY1
    w := mouseX1 > mouseX0 ? mouseX1 - mouseX0 : mouseX0 - mouseX1
    h := mouseY1 > mouseY0 ? mouseY1 - mouseY0 : mouseY0 - mouseY1
    screenDim=%x%|%y%|%w%|%h%
    saveScreenshot(screenDim)

    restoreCursor()
    return

overlay:
    MouseGetPos, tx, ty
    ttx := tx > mouseX0 ? mouseX0 : tx
    tty := ty > mouseY0 ? mouseY0 : ty
    ttw := tx > mouseX0 ? tx - mouseX0 : mouseX0 - tx
    tth := ty > mouseY0 ? ty - mouseY0 : mouseY0 - ty
    Gui, Show, x%ttx% y%tty% w%ttw% h%tth%
    return

setPlusCursor() {
    ; Windows API and list of system cursors:
    ; https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-setsystemcursor

    systemCursors := { OCR_APPSTARTING: 32650  ; Working in background
                  , OCR_CROSS: 32515        ; Precision select
                  , OCR_HAND: 32649         ; Link select
                  , OCR_IBEAM: 32513        ; Text select
                  , OCR_NO: 32648           ; Unavailable
                  , OCR_NORMAL: 32512       ; Normal select
                  , OCR_SIZEALL: 32646      ; Move
                  , OCR_SIZENESW: 32643     ; Diagonal resize 2
                  , OCR_SIZENS: 32645       ; Vertical resize
                  , OCR_SIZENWSE: 32642     ; Diagonal resize 1
                  , OCR_SIZEWE: 32644       ; Horizontal resize
                  , OCR_UP: 32516           ; Alternate select
                  , OCR_WAIT: 32514 }       ; Busy

    for cursorName, cursorId in systemCursors {
        plusCursorHandle := DllCall("LoadCursor", UInt, 0, Int, systemCursors["OCR_CROSS"])
        if (cursorId != OCR_CROSS) {
            DllCall("SetSystemCursor", Ptr, plusCursorHandle, UInt, cursorId)
        }
    }

    return
}

restoreCursor() {
	SPI_SETCURSORS := 0x57
	DllCall( "SystemParametersInfo", UInt,SPI_SETCURSORS, UInt,0, UInt,0, UInt,0 )
    return
}

saveScreenshot(screenDim, toClipboard=true) {
    outfile := getFileName()
    pToken := Gdip_Startup()
    pBitmap := Gdip_BitmapFromScreen(screenDim)
    if (toClipboard) {
        Gdip_SetBitmapToClipboard(pBitmap)
    }
    Gdip_SaveBitmapToFile(pBitmap, outfile, 100)
    Gdip_DisposeImage(pBitmap)
    Gdip_Shutdown(pToken)
    showMessage("Screenshot", "")
}

getFileName() {
    global IMDIR
    mmdd_date := A_MM A_DD
    yymmdd_date := SubStr(A_YYYY,-1) mmdd_date
    hhmmss_time := A_Hour A_Min A_Sec
    filename := "ss-" yymmdd_date "-" hhmmss_time
    return IMDIR filename ".png"
}
