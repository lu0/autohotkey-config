#NoTrayIcon
#SingleInstance Force
#NoEnv
#Include %A_ScriptDir%\..\workspaces\utils.ahk

; This script toggles the Windows 10 'rotation lock' feature

; Run as administrator
; Required to modify registry keys
full_command_line := DllCall("GetCommandLine", "str")
if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
    try
        Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"

; Keybinding definition
; super + o
#o::ToggleRotationLock()

getRotationValues(ByRef rotationEnabled, ByRef rotationSlateEnabled) {
    RegRead, rotationEnabled, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AutoRotation, Enable
    RegRead, rotationSlateEnabled, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AutoRotation, SlateEnable
}

setRotationValues(rotationEnabled, rotationSlateEnabled) {
    RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AutoRotation, Enable, % rotationEnabled
    RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AutoRotation, SlateEnable, % rotationSlateEnabled
}

ToggleRotationLock() {
    getRotationValues(rotationEnabled, rotationSlateEnabled)
    setRotationValues(!rotationEnabled, !rotationSlateEnabled)
    getRotationValues(rotationEnabled, rotationSlateEnabled)
    
    notificationTitle := "Toggle Rotation Lock"
    notificationMessage := "Auto rotation " ((rotationEnabled == 1) ? ("Enabled") : ("Disabled"))
    showMessage(notificationTitle, notificationMessage)
}
