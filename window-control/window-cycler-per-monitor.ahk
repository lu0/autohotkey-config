#SingleInstance Force
CoordMode, Mouse, Screen

; This script cycles through all non-minimized windows for the current monitor
; (the one with an active window) by pushing the top window to the bottom,
; activating the next window and centering the mouse cursor on it.
; Adjusted (to center the mouse cursor and to ignore the 'Program Manager' window)
; and refactored from: https://www.autohotkey.com/boards/viewtopic.php?t=54972

; Override the default window cycler (Alt+Tab and Alt+Shift+Tab)
!Tab:: cycleWindows("forward")
!+Tab:: cycleWindows("backward")

; Unminimize all windows (the cycler works with non-minimized windows)
^!d:: restoreWindows()


cycleWindows(direction) {
    ; restoreWindows()
    Screen := 0
	Monitor := []
    Windows := []

	Loop, % DllCall("GetSystemMetrics", "int", 80) { ;SM_CMONITORS
		SysGet, Mon, Monitor, %A_Index%
		Monitor[A_Index] := {Left: MonLeft, Right: MonRight, Top: MonTop, Bottom: MonBottom}
		Windows[A_Index] := []
	}

	DetectHiddenWindows, Off
	WinGet, List, List

	Loop % List {
		hwnd := List%A_Index%

        If not getIsWindowValid(hwnd)
            continue

		WinGetPos, x, y, w, h, % "ahk_id " hwnd
		cx := x + w/2
        cy := y + h/2

		For k,Mon in Monitor
			If (cx>=Mon.Left && cx<Mon.Right && cy>=Mon.Top && cy<Mon.Bottom) {
				ID := k
				Windows[ID].Push(hwnd)
				If (Screen=0)
					Screen := ID
				Break
			}
	}

    totalWindowsOnCurrentMonitor := Windows[Screen].Length()
    
    if (totalWindowsOnCurrentMonitor > 1) {
        hwndFirst := Windows[Screen][1]
        Last := Windows[Screen].MaxIndex()
        hwndLast := Windows[Screen][Last]

        if (direction = "forward") {
            DllCall("SetWindowPos", "ptr"
                , hwndFirst, "ptr", 1, "int", 0, "int", 0, "int", 0, "int", 0
                , "uint", 0x13) ; NOSIZE|NOMOVE|NOACTIVATE (0x1|0x2|0x10)
            nextWindow := % "ahk_id " Windows[Screen][2]
        } else {
            ; Backward
            DllCall("SetWindowPos", "ptr"
                , hwndLast, "ptr", 0, "int", 0, "int", 0, "int", 0, "int", 0
                , "uint", 0x13) ; NOSIZE|NOMOVE|NOACTIVATE (0x1|0x2|0x10)
            nextWindow := % "ahk_id " hwndLast
        }

        ; Center mouse on window to avoid focus on other windows
        ; when the system is configured to focus on mouse hover.
        WinGetPos, x, y, w, h, % nextWindow
        centerMouseOnWindow(x, y, w, h)

        ; Raise the window
        WinActivate, % nextWindow
    }

}

getIsWindowValid(hwnd) {
    isWindowValid := true
    WinGetTitle, winTitle, % "ahk_id " hwnd
    If (winTitle = "" or winTitle = "Program Manager" or !hasTaskbar(hwnd))
        isWindowValid := false
    return isWindowValid
}

hasTaskbar(hwnd) {
    WinGet, Style, Style, % "ahk_id " hwnd
    return Style & 0xC00000
}

centerMouseOnWindow(x, y, w, h) {
    cx := x + w/2
    cy := y + h/2
    MouseMove, %cx%, %cy%, 0
}

restoreWindows() {
    WinGet, List, List
    Loop % List {
        hwnd := List%A_Index%
        WinGet, hwndMinMax, MinMax,% "ahk_id " hwnd
        If hwndMinMax =-1 ;minimised
            WinRestore,% "ahk_id " hwnd
    }
    return
}
