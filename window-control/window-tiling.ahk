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
    MonitorGetWorkAreaRelPos(monitorX1, monitorX2, monitorY1, monitorY2, monitorWidth, monitorHeight, true)
    WinGetTileMaximizedPosFromMonitor("max", tileGap, monitorX1, monitorY1, monitorWidth, monitorHeight, newWindowX, newWindowY, newWindowWidth, newWindowHeight)
    WindowMoveAndResize(oldWinTitle, newWinTitle, newWindowX, newWindowY, newWindowWidth, newWindowHeight)
    return


; Tile Left / Move window to the other monitor
LAlt & a::
    winGetTitlesAndActiveStatus(oldWinTitle, newWinTitle, activeStatus)
    if not activeStatus {
        return
    }

    if (not GetKeyState("Shift") and not GetKeyState("LWin")) {
        ; Tile Left on current monitor
        ; alt + a
        MonitorGetWorkAreaRelPos(monitorX1, monitorX2, monitorY1, monitorY2, monitorWidth, monitorHeight, true)
        WinGetTileMaximizedPosFromMonitor("left", tileGap, monitorX1, monitorY1, monitorWidth, monitorHeight, newWindowX, newWindowY, newWindowWidth, newWindowHeight)
    } else if (GetKeyState("LWin")) {
        ; Tile-maximize  on the other monitor
        ; super + alt + a
        MonitorGetWorkAreaRelPos(monitorX1, monitorX2, monitorY1, monitorY2, monitorWidth, monitorHeight, false)
        WinGetTileMaximizedPosFromMonitor("max", tileGap, monitorX1, monitorY1, monitorWidth, monitorHeight, newWindowX, newWindowY, newWindowWidth, newWindowHeight)
    } else {
        ; Alt + Shift + A
        Send !+{a}
        return
    }

    WindowMoveAndResize(oldWinTitle, newWinTitle, newWindowX, newWindowY, newWindowWidth, newWindowHeight)
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
        MonitorGetWorkAreaRelPos(monitorX1, monitorX2, monitorY1, monitorY2, monitorWidth, monitorHeight, true)
        WinGetTileMaximizedPosFromMonitor("left-top", tileGap, monitorX1, monitorY1, monitorWidth, monitorHeight, newWindowX, newWindowY, newWindowWidth, newWindowHeight)
        WindowMoveAndResize(oldWinTitle, newWinTitle, newWindowX, newWindowY, newWindowWidth, newWindowHeight)
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
        MonitorGetWorkAreaRelPos(monitorX1, monitorX2, monitorY1, monitorY2, monitorWidth, monitorHeight, true)
        WinGetTileMaximizedPosFromMonitor("left-bottom", tileGap, monitorX1, monitorY1, monitorWidth, monitorHeight, newWindowX, newWindowY, newWindowWidth, newWindowHeight)
        WindowMoveAndResize(oldWinTitle, newWinTitle, newWindowX, newWindowY, newWindowWidth, newWindowHeight)
    } else {
        ; Alt + Shift + Z
        Send !+{z}
    }
    return
 

; Tile Right
; alt + d
LAlt & d::
    winGetTitlesAndActiveStatus(oldWinTitle, newWinTitle, activeStatus)
    if not activeStatus {
        return
    }

    if (not GetKeyState("Shift") and not GetKeyState("LWin")) {
        ; Tile Left on current monitor
        ; alt + a
        MonitorGetWorkAreaRelPos(monitorX1, monitorX2, monitorY1, monitorY2, monitorWidth, monitorHeight, true)
        WinGetTileMaximizedPosFromMonitor("right", tileGap, monitorX1, monitorY1, monitorWidth, monitorHeight, newWindowX, newWindowY, newWindowWidth, newWindowHeight)
    } else if (GetKeyState("LWin")) {
        ; Tile-maximize  on the other monitor
        ; super + alt + d
        MonitorGetWorkAreaRelPos(monitorX1, monitorX2, monitorY1, monitorY2, monitorWidth, monitorHeight, false)
        WinGetTileMaximizedPosFromMonitor("max", tileGap, monitorX1, monitorY1, monitorWidth, monitorHeight, newWindowX, newWindowY, newWindowWidth, newWindowHeight)
    } else {
        ; Alt + Shift + d
        Send !+{d}
        return
    }
    WindowMoveAndResize(oldWinTitle, newWinTitle, newWindowX, newWindowY, newWindowWidth, newWindowHeight)
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
        MonitorGetWorkAreaRelPos(monitorX1, monitorX2, monitorY1, monitorY2, monitorWidth, monitorHeight, true)
        WinGetTileMaximizedPosFromMonitor("right-top", tileGap, monitorX1, monitorY1, monitorWidth, monitorHeight, newWindowX, newWindowY, newWindowWidth, newWindowHeight)
        WindowMoveAndResize(oldWinTitle, newWinTitle, newWindowX, newWindowY, newWindowWidth, newWindowHeight)
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
        MonitorGetWorkAreaRelPos(monitorX1, monitorX2, monitorY1, monitorY2, monitorWidth, monitorHeight, true)
        WinGetTileMaximizedPosFromMonitor("right-bottom", tileGap, monitorX1, monitorY1, monitorWidth, monitorHeight, newWindowX, newWindowY, newWindowWidth, newWindowHeight)
        WindowMoveAndResize(oldWinTitle, newWinTitle, newWindowX, newWindowY, newWindowWidth, newWindowHeight)
    } else {
        ; Alt + Shift + C
        Send !+{c}
    }
    return


MonitorGetWorkAreaRelPos(ByRef monitorX1, ByRef monitorX2, ByRef monitorY1, ByRef monitorY2, ByRef monitorWidth, ByRef monitorHeight, isCurrent) {
    ; Get the relative position of the current monitor if isCurrent = true
    ; else get the relative position of the other monitor.
    ; This works for setups with up to 2 monitors.
    CoordMode, Mouse, Screen
    MouseGetPos, mouseX, mouseY
    SysGet, monitorCount, MonitorCount
    Loop, %monitorCount%
    {
        SysGet, workArea, MonitorWorkArea, %A_Index%
        isMouseInMonitor := mouseX > workAreaLeft and mouseX < workAreaRight and mouseY > workAreaTop and mouseY < workAreaBottom
        if ((isMouseInMonitor and isCurrent) or (not isMouseInMonitor and not isCurrent)) {
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


WindowMoveAndResize(oldWinTitle, newWinTitle, newWindowX, newWindowY, newWindowWidth, newWindowHeight) {
    ; Move and resize
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


WinGetTileMaximizedPosFromMonitor(tileType, tileGap, x, y, width, height, ByRef winX, ByRef winY, ByRef winWidth, ByRef winHeight) {
    ; Default to maximize
    winWidth := width - tileGap*2
    winHeight := height - tileGap*2
    winX := x + tileGap
    winY := y + tileGap

    ; Overrides
    if InStr(tileType, "left") or InStr(tileType, "right") {
        winWidth := width/2 - tileGap*1.5
    }
    
    if InStr(tileType, "top") or InStr(tileType, "bottom"){
        winHeight := height/2 - tileGap*1.5
    }

    if InStr(tileType, "bottom") {
        winY := y + tileGap*1.5 + winHeight
    }

    if  InStr(tileType, "right") {
        winX := x + winWidth + tileGap*2
    }
    return
}
