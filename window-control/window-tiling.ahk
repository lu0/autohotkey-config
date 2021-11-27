#NoTrayIcon
#SingleInstance Force

; Keybindings I use on Linux to close, minimize, maximize and snap the active window.
; Must enable "Zone index" on FancyZones (Windows Powertoys) and use a gap greater than 0.

; Close
; ctrl + super + space
^#Space::
    PostMessage, 0x112, 0xF060,,, A
return

; Minimize
; left alt + x
LAlt & x::
    Send #{down}
return

; Toggle maximize/unmaximize
; left alt + space
LAlt & space::
    WinGetTitle, winname, A
    WinGetPos, X, Y, Width, Height, %winname%
    if (Y > 0)
        Send #{up}
    else if (Y <= 0)
        Send #{down}
    return

; Snap/move to the left
; alt + a
LAlt & a::
    if not GetKeyState("Shift")
        Send #{left}
    else
        ; Alt + Shift + A
        Send !+{a}
    return
 
; Snap/move to the right
; alt + d
LAlt & d::
    Send #{right}
return
