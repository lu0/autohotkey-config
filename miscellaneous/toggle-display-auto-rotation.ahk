#NoTrayIcon
#SingleInstance Force
#NoEnv

; This script toggles the Windows 10 'rotation lock' feature

;super + o
#o::ToggleRotationLock()

ToggleRotationLock() {
    RegRead, rotationEnabled, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AutoRotation, Enable
    RegRead, rotationSlateEnabled, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AutoRotation, SlateEnable
    RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AutoRotation, Enable, % !rotationEnabled
    RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AutoRotation, SlateEnable, % !rotationSlateEnabled
}
