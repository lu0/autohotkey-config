#NoTrayIcon
#SingleInstance Force
CoordMode, Mouse, Screen

; Keybindings I use on Linux to tile, close, minimize and maximize the active window.
; alt + <a, d>          Tile  left and right.
; alt + <c, e, q, z>    Tile to a quadrant.
; alt + <space, x>      Maximize (with gaps) and Minimize.
; ctrl + alt + space    Close.

tileGap := 10

; Start keybindings ----------------------------------------------------------

; Close
; ctrl + super + space
^#Space::
    WinClose, A
return

; Minimize
; left alt + x
LAlt & x::
    WinMinimize, A
return

; Maximize
; left alt + space
LAlt & space::
    winGetTitlesAndActiveStatus(oldWinTitle, newWinTitle, activeStatus)
        if not activeStatus {
            return
        }

    ; Get relative position and work dimensions of the current monitor and mouse
    CurrMonitorGetWorkAreaRelPos(monitorX1, monitorX2, monitorY1, monitorY2, monitorWidth, monitorHeight)

    MouseGetPos, mouseX, mouseY
    if (mouseX > monitorX1 and mouseX < monitorX2 and mouseY > monitorY1 and mouseY < monitorY2) {
        ; Move and resize window
        newWindowX := monitorX1 + tileGap
        newWindowY := monitorY1 + tileGap
        newWindowWidth := monitorWidth - tileGap*2
        newWindowHeight := monitorHeight - tileGap*2
        WinRestore, %newWinTitle%   ; restore in case of built-in maximization
        WinMove, %newWinTitle%,, %newWindowX%, %newWindowY%, %newWindowWidth%, %newWindowHeight%

        ; Center the mouse
        newMouseX := newWindowX + newWindowWidth/2
        newMouseY := newWindowY + newWindowHeight/2
        MouseMove, %newMouseX%, %newMouseY%, 0
        WinActivate, %newWinTitle%
        WinSetTitle, %newWinTitle%, , %oldWinTitle%
    }
    return


; Tile Left
; alt + a
LAlt & a::
    if (not GetKeyState("Shift")) {
        winGetTitlesAndActiveStatus(oldWinTitle, newWinTitle, activeStatus)
        if not activeStatus {
            return
        }

        ; Get relative position and work dimensions of the current monitor and mouse
        CurrMonitorGetWorkAreaRelPos(monitorX1, monitorX2, monitorY1, monitorY2, monitorWidth, monitorHeight)

        MouseGetPos, mouseX, mouseY
        if (mouseX > monitorX1 and mouseX < monitorX2 and mouseY > monitorY1 and mouseY < monitorY2) {
            ; Move and resize window
            newWindowWidth := monitorWidth/2 - tileGap*1.5
            newWindowHeight := monitorHeight - tileGap*2
            newWindowX := monitorX1 + tileGap
            newWindowY := monitorY1 + tileGap
            WinRestore, %newWinTitle%   ; restore in case of built-in maximization
            WinMove, %newWinTitle%,, %newWindowX%, %newWindowY%, %newWindowWidth%, %newWindowHeight%

            ; Center the mouse
            newMouseX := newWindowX + newWindowWidth/2
            newMouseY := newWindowY + newWindowHeight/2
            MouseMove, %newMouseX%, %newMouseY%, 0
            WinActivate, %newWinTitle%
            WinSetTitle, %newWinTitle%, , %oldWinTitle%
            return
        }
    } else {
        ; Alt + Shift + A
        Send !+{a}
    }
    return


; Tile Left-Top
; alt + q
LAlt & q::
    if (not GetKeyState("Shift")) {
        winGetTitlesAndActiveStatus(oldWinTitle, newWinTitle, activeStatus)
        if not activeStatus {
            return
        }

        ; Get relative position and work dimensions of the current monitor and mouse
        CurrMonitorGetWorkAreaRelPos(monitorX1, monitorX2, monitorY1, monitorY2, monitorWidth, monitorHeight)

        MouseGetPos, mouseX, mouseY
        if (mouseX > monitorX1 and mouseX < monitorX2 and mouseY > monitorY1 and mouseY < monitorY2) {
            ; Move and resize window
            newWindowWidth := monitorWidth/2 - tileGap*1.5
            newWindowHeight := monitorHeight/2 - tileGap*1.5
            newWindowX := monitorX1 + tileGap
            newWindowY := monitorY1 + tileGap
            WinRestore, %newWinTitle%   ; restore in case of built-in maximization
            WinMove, %newWinTitle%,, %newWindowX%, %newWindowY%, %newWindowWidth%, %newWindowHeight%

            ; Center the mouse
            newMouseX := newWindowX + newWindowWidth/2
            newMouseY := newWindowY + newWindowHeight/2
            MouseMove, %newMouseX%, %newMouseY%, 0
            WinActivate, %newWinTitle%
            WinSetTitle, %newWinTitle%, , %oldWinTitle%
            return
        }
    } else {
        ; Alt + Shift + Q
        Send !+{q}
    }
    return


; Tile Left-Bottom
; alt + z
LAlt & z::
    if (not GetKeyState("Shift")) {
        winGetTitlesAndActiveStatus(oldWinTitle, newWinTitle, activeStatus)
        if not activeStatus {
            return
        }

        ; Get relative position and work dimensions of the current monitor and mouse
        CurrMonitorGetWorkAreaRelPos(monitorX1, monitorX2, monitorY1, monitorY2, monitorWidth, monitorHeight)

        MouseGetPos, mouseX, mouseY
        if (mouseX > monitorX1 and mouseX < monitorX2 and mouseY > monitorY1 and mouseY < monitorY2) {
            ; Move and resize window
            newWindowWidth := monitorWidth/2 - tileGap*1.5
            newWindowHeight := monitorHeight/2 - tileGap*1.5
            newWindowX := monitorX1 + tileGap
            newWindowY := monitorY1 + tileGap*1.5 + newWindowHeight
            WinRestore, %newWinTitle%   ; restore in case of built-in maximization
            WinMove, %newWinTitle%,, %newWindowX%, %newWindowY%, %newWindowWidth%, %newWindowHeight%

            ; Center the mouse
            newMouseX := newWindowX + newWindowWidth/2
            newMouseY := newWindowY + newWindowHeight/2
            MouseMove, %newMouseX%, %newMouseY%, 0
            WinActivate, %newWinTitle%
            WinSetTitle, %newWinTitle%, , %oldWinTitle%
            return
        }
    } else {
        ; Alt + Shift + Z
        Send !+{z}
    }
    return
 

; Tile Right
; alt + d
LAlt & d::
    if not GetKeyState("Shift") {
        winGetTitlesAndActiveStatus(oldWinTitle, newWinTitle, activeStatus)
        if not activeStatus {
            return
        }

        ; Get relative position and work dimensions of the current monitor and mouse
        CurrMonitorGetWorkAreaRelPos(monitorX1, monitorX2, monitorY1, monitorY2, monitorWidth, monitorHeight)

        MouseGetPos, mouseX, mouseY
        if (mouseX > monitorX1 and mouseX < monitorX2 and mouseY > monitorY1 and mouseY < monitorY2) {
            ; Move and resize window
            newWindowWidth := monitorWidth/2 - tileGap*1.5
            newWindowHeight := monitorHeight - tileGap*2
            newWindowX := monitorX1 + newWindowWidth + tileGap*2
            newWindowY := monitorY1 + tileGap
            WinRestore, %newWinTitle%   ; restore in case of built-in maximization
            WinMove, %newWinTitle%,, %newWindowX%, %newWindowY%, %newWindowWidth%, %newWindowHeight%

            ; Center the mouse
            newMouseX := newWindowX + newWindowWidth/2
            newMouseY := newWindowY + newWindowHeight/2
            MouseMove, %newMouseX%, %newMouseY%, 0
            WinActivate, %newWinTitle%
            WinSetTitle, %newWinTitle%, , %oldWinTitle%
            return
        }
    } else {
        ; Alt + Shift + A
        Send !+{a}
    }
    return


; Tile Right-Top
; alt + e
LAlt & e::
    if not GetKeyState("Shift") {
        winGetTitlesAndActiveStatus(oldWinTitle, newWinTitle, activeStatus)
        if not activeStatus {
            return
        }

        ; Get relative position and work dimensions of the current monitor and mouse
        CurrMonitorGetWorkAreaRelPos(monitorX1, monitorX2, monitorY1, monitorY2, monitorWidth, monitorHeight)

        MouseGetPos, mouseX, mouseY
        if (mouseX > monitorX1 and mouseX < monitorX2 and mouseY > monitorY1 and mouseY < monitorY2) {
            ; Move and resize window
            newWindowWidth := monitorWidth/2 - tileGap*1.5
            newWindowHeight := monitorHeight/2 - tileGap*1.5
            newWindowX := monitorX1 + newWindowWidth + tileGap*2
            newWindowY := monitorY1 + tileGap
            WinRestore, %newWinTitle%   ; restore in case of built-in maximization
            WinMove, %newWinTitle%,, %newWindowX%, %newWindowY%, %newWindowWidth%, %newWindowHeight%

            ; Center the mouse
            newMouseX := newWindowX + newWindowWidth/2
            newMouseY := newWindowY + newWindowHeight/2
            MouseMove, %newMouseX%, %newMouseY%, 0
            WinActivate, %newWinTitle%
            WinSetTitle, %newWinTitle%, , %oldWinTitle%
            return
        }
    } else {
        ; Alt + Shift + E
        Send !+{e}
    }
    return


; Tile Right-Bottom
; alt + c
LAlt & c::
    if not GetKeyState("Shift") {
        winGetTitlesAndActiveStatus(oldWinTitle, newWinTitle, activeStatus)
        if not activeStatus {
            return
        }

        ; Get relative position and work dimensions of the current monitor and mouse
        CurrMonitorGetWorkAreaRelPos(monitorX1, monitorX2, monitorY1, monitorY2, monitorWidth, monitorHeight)

        MouseGetPos, mouseX, mouseY
        if (mouseX > monitorX1 and mouseX < monitorX2 and mouseY > monitorY1 and mouseY < monitorY2) {
            ; Move and resize window
            newWindowWidth := monitorWidth/2 - tileGap*1.5
            newWindowHeight := monitorHeight/2 - tileGap*1.5
            newWindowX := monitorX1 + newWindowWidth + tileGap*2
            newWindowY := monitorY1 + tileGap*1.5 + newWindowHeight 
            WinRestore, %newWinTitle%   ; restore in case of built-in maximization
            WinMove, %newWinTitle%,, %newWindowX%, %newWindowY%, %newWindowWidth%, %newWindowHeight%

            ; Center the mouse
            newMouseX := newWindowX + newWindowWidth/2
            newMouseY := newWindowY + newWindowHeight/2
            MouseMove, %newMouseX%, %newMouseY%, 0
            WinActivate, %newWinTitle%
            WinSetTitle, %newWinTitle%, , %oldWinTitle%
            return
        }
    } else {
        ; Alt + Shift + C
        Send !+{c}
    }
    return


CurrMonitorGetWorkAreaRelPos(ByRef monitorX1, ByRef monitorX2, ByRef monitorY1, ByRef monitorY2, ByRef monitorWidth, ByRef monitorHeight) {
    ; Get the relative position of the monitor where the mouse is in
    ; Usage is similar to that of WinGetPos:
    ;   CurrMonitorGetWorkAreaRelPos(X1, X2, Y1, Y2, Width, Height)
    CoordMode, Mouse, Screen
    MouseGetPos, mouseX, mouseY
    SysGet, monitorCount, MonitorCount
    Loop, %monitorCount%
    {
        SysGet, workArea, MonitorWorkArea, %A_Index%
        if (mouseX > workAreaLeft and mouseX < workAreaRight and mouseY > workAreaTop and mouseY < workAreaBottom) {
            monitorX1 :=  workAreaLeft
            monitorX2 :=  workAreaRight
            monitorY1 := workAreaTop
            monitorY2 := workAreaBottom
            monitorWidth := Abs(workAreaRight - workAreaLeft)
            monitorHeight := Abs(workAreaBottom - workAreaTop)
            return
        }
    }
}


winGetTitlesAndActiveStatus(ByRef oldWinTitle, ByRef newWinTitle, ByRef activeStatus) {
    ; Check if a window is active and get its title
    activeStatus := true
    WinGetTitle, oldWinTitle, A
    newWinTitle := oldWinTitle
    if (oldWinTitle = "" or oldWinTitle = "Program Manager") {
        activeStatus := false
        return
    }

    ; Change the title in case we have more windows with the same one
    Random, rand, 1000, 9999
    resizeIndicator := " (" . rand . ")"
    newWinTitle := oldWinTitle . resizeIndicator
    WinSetTitle, %oldWinTitle%, , %newWinTitle%
    return
}
