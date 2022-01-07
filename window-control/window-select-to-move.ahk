#NoTrayIcon
#SingleInstance Force

; This scripts move the mouse to the titlebar of the active window
; and holds a click on the left button of the mouse in order to
; move the window by using Alt + M

!m::
    CoordMode , Mouse, Screen
    WinGetTitle , old_title, A
    move_indicator := " (moving)"

    if (old_title = "" or old_title = "Program Manager") {
        return
    }

    ; Change the title in case we have more windows with the same one
    new_title := old_title . move_indicator
    WinSetTitle , A, , %new_title%

    ; Get position of the title bar
    WinGetPos , win_x, win_y, win_w, win_h, A
    titlebar_x_middle := win_x + win_w / 2
    titlebar_y := win_y + 10

    ; Offset to avoid grabbing tabs when using Vivaldi (web browser).
    substring := "Vivaldi"
    IfInString, new_title, %substring%
        titlebar_y -= 5

    ; Move the mouse to the title bar
    WinActivate , Program Manager
    MouseMove , %titlebar_x_middle%, %titlebar_y%, 0

    ; Activate the window and restore its title
    WinActivate , %new_title%
    WinSetTitle , A, , %old_title%

    ; Click and hold
    MouseClick , left, , , , 0, D
    return
    