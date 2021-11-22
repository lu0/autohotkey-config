#NoTrayIcon
#SingleInstance Force

; Override conflicting keybindings on Windows 10

; super + a
; I use it on vivaldi
#a::
   Send {F6}
   return

; super + q
; I use it on vivaldi
#q::
    Send {F2}
    return

; map shift + super + a
; to  ctrl + shift + PgUp
; I use it on vscode and vivaldi
+#a::
    Send ^+{PgUp}
    return

; map shift + super + a
; to  ctrl + shift + PgDn
; I use it on vscode and vivaldi
+#s::
    Send ^+{PgDn}
    return

; map ctrl + alt + tab
; to  ctrl + alt + ;
; I use it on vscode and vivaldi
^!tab::
    Send ^!`´
    return

; Override Ctrl + (emulated)Esc
;     with Ctrl + 1
; I use it on vscode
^CapsLock::
    Send ^{1}
    return

; Disable the "office" shortcut
; https://www.autohotkey.com/boards/viewtopic.php?t=65573
#^!Shift::
#^+Alt::
#!+Ctrl::
^!+LWin::
^!+RWin::
    Send {Blind}{vk07}
    return

; Override Super + Shift + Space
;       with ctrl+shift+alt+w
; I use it on vscode
+#Space::
    Send ^+!{w}
    return
