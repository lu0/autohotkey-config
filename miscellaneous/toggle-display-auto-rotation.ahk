#NoTrayIcon
#SingleInstance Force
#NoEnv

; This script toggles the Windows 10 'rotation lock' feature

; Run as administrator
; Required to modify registry keys
full_command_line := DllCall("GetCommandLine", "str")
if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
    try
        Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"

;super + o
#o::ToggleRotationLock()

ToggleRotationLock() {
    RegRead, rotationEnabled, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AutoRotation, Enable
    RegRead, rotationSlateEnabled, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AutoRotation, SlateEnable
    RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AutoRotation, Enable, % !rotationEnabled
    RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AutoRotation, SlateEnable, % !rotationSlateEnabled
}
