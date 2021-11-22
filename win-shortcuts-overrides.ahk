#NoTrayIcon
#SingleInstance Force

; Override conflicting keybindings on Windows 10

; super + a
; Focus navigation bar
#a::
   Send {F6}
   return

; super + q
; F2 is usually used for quick commands
#q::
    Send {F2}
    return

; map alt + super + a
; to  ctrl + shift + PgUp
; To move a tab backwards
+#a::
    Send ^+{PgUp}
    return

; map alt + super + a
; to  ctrl + shift + PgDn
; To move a tab forward
+#s::
    Send ^+{PgDn}
    return


; map ctrl + alt + tab
; to  ctrl + alt + ;
^!tab::
    Send ^!`´
    return

; Override Ctrl + (emulated)Esc
;       to Ctrl + 1
; Used in my vscode settings to toggle the sidebar
^CapsLock::
    Send ^{1}
    return
