#NoTrayIcon
#SingleInstance Force
#NoEnv

; This script shows the Shutdown Dialog when pressing Super + P,
; the same keybinding I use on Linux

#p::ShowPowermenu()

; Snippet taken and adjusted from 
; https://www.autohotkey.com/boards/viewtopic.php?t=81268
ShowPowermenu(ChooseString:="") {
    ComObjCreate("Shell.Application").ShutdownWindows()
    WinWait, Shut Down Windows
    Control, ChooseString, %ChooseString%, ComboBox1
    WinSet, AlwaysOnTop, 1
    WinWaitClose
    Return
}
