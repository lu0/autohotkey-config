/*
This script helps manage the OBS Studio recording feature while preventing
interference with Bluetooth headset operation.

Often when a program uses, monitors, or even detects a microphone, the Bluetooth
headset shifts to 'call mode', impacting audio quality. This script mitigates
this by only running OBS when needed and closing it when idle, preserving
optimal audio output when possible.

The script interacts with OBS's main and ffmpeg processes, using hotkeys to
start and stop recordings. If OBS Studio isn't currently active, executing the
script will launch OBS and initiate a recording. If OBS is already running and
recording, the script will stop the recording. OBS will be closed upon script
completion.

Update the paths to the OBS executable and hotkeys before using the script
if they don't match your system.

The script also includes sound cues to alert the start or stop of a recording,
or if an error occurs. Paths to these audio files need to be set accordingly,
but the current ones should function with any Windows 10/11 installation.

IMPORTANT: OBS needs to have hotkeys configured for starting and stopping
recordings for this script to function correctly. The script defaults to using
Ctrl+Alt+Shift+R to start and Ctrl+Alt+Shift+T to stop recordings, but these can
be adjusted as needed.
*/


#NoEnv
#NoTrayIcon
#SingleInstance Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

CtrlAltR := "^!r"
CtrlShiftAltR := "^+!r"
CtrlShiftAltT := "^!+t"

global scriptHotKeyTrigger := CtrlAltR
global obsHotkeyStartRecording := CtrlShiftAltR
global obsHotkeyStopRecording := CtrlShiftAltT

global obsExecutablePath := "C:\Program Files\obs-studio\bin\64bit\obs64.exe"
global obsDesktopProcess := "obs64.exe"
global obsRecordingProcess := "obs-ffmpeg-mux.exe"
global obsWindowTitleRegex := "^OBS.*64-bit.*"

global errorSound := "C:\Windows\Media\Windows Critical Stop.wav"
global startRecordingSound := "C:\Windows\Media\Speech On.wav"
global stopRecordingSound := "C:\Windows\Media\Speech Off.wav"

global obsDesktopOpenTimeoutSeconds := 5
global obsStartRecordingTimeoutSeconds := 5
global obsStopRecordingTimeoutSeconds := 20
global obsDesktopCloseTimeoutSeconds := 5

HotKey, %scriptHotKeyTrigger%, OnScriptActivation
return

main() {
    if isProcessRunning(obsDesktopProcess) {
        stopRecordingAndCloseObs()
    } else {
        openObsAndStartRecording()
    }
}

openObsAndStartRecording() {
    openObsInMinimizedMode()
    startObsRecording()
    SoundPlay, %startRecordingSound%
}

stopRecordingAndCloseObs() {
    if isProcessRunning(obsRecordingProcess) {
        stopObsRecording()
    }
    closeObs()
    SoundPlay, %stopRecordingSound%
}

openObsInMinimizedMode() {
    obsDir := RegExReplace(obsExecutablePath, "\\[^\\]*$")
    Run, %obsExecutablePath%, %obsDir%, Min
    waitProcessOpening(obsDesktopProcess, obsDesktopOpenTimeoutSeconds)
}

startObsRecording() {
    ; Simply sending the hotkey and calling waitProcessOpening() for the 
    ; recording process may not be enough, as OBS might not be immediately 
    ; ready to accept hotkeys, even if the process is running. OBS's readiness
    ; to accept hotkeys can vary depending on factors like system performance
    ; and load
    ;
    ; To handle this, we use a loop to repeatedly send the hotkey command to
    ; start the recording and then check if OBS has successfully started the
    ; recording process. This loop is constrained by a timeout.

    loopStartTime := A_TickCount
    loopElapsedSeconds := 0
    while (loopElapsedSeconds <= obsStartRecordingTimeoutSeconds) {
        Send, %obsHotkeyStartRecording%
        if isProcessRunning(obsRecordingProcess) {
            OutputDebug, % "OBS accepted the hotkey after " .  loopElapsedSeconds . " seconds."
            return
        }
        loopElapsedSeconds := (A_TickCount - loopStartTime) / 1000
    }
    OutputDebug, % "Recording process not found, timeout: " . obsStartRecordingTimeoutSeconds
    closeObs()
    failScript()
}

stopObsRecording() {
    activateHiddenWindow(obsWindowTitleRegex)
    Send, %obsHotkeyStopRecording%
    waitProcessClosing(obsRecordingProcess, obsStopRecordingTimeoutSeconds)
}

closeObs() {
    if isProcessRunning(obsDesktopProcess) {
        activateHiddenWindow(obsWindowTitleRegex)
        WinClose, ahk_exe %obsDesktopProcess%
        waitProcessClosing(obsDesktopProcess, obsDesktopCloseTimeoutSeconds)
    }
}

activateHiddenWindow(windowTitleRegex) {
    try {
        BlockInput, On
        DetectHiddenWindows, On
        SetTitleMatchMode, RegEx
        WinShow, %windowTitleRegex%
        WinActivate, %windowTitleRegex%
    } finally {
        BlockInput, Off
    }
}

isProcessRunning(processName) {
    Process, Exist, %processName%
    return ErrorLevel != 0
}

waitProcessOpening(processName, timeoutSeconds) {
    Process, Wait, %processName%, %timeoutSeconds%
    isProcessOpen := ErrorLevel != 0
    if not isProcessOpen {
        OutputDebug, % "Process not found: " . processName . ", timeout: " . timeoutSeconds
        failScript()
    }
    return isProcessOpen
}

waitProcessClosing(processName, timeoutSeconds) {
    Process, WaitClose, %processName%, %timeoutSeconds%
    isProcessClosed := ErrorLevel = 0
    if not isProcessClosed {
        OutputDebug, % "Error closing " . processName . ", timeout: " . timeoutSeconds
        failScript()
    }
    return isProcessClosed
}

failScript() {
    ; Since we enforce a single instance of the script, we can just reaload it
    ; to terminate the current execution and start the script all over again
    ; on failure. We use this instead of ExitApp to prevent the script from
    ; stopping listening to the hotkey that triggers it.
    SoundPlay, %errorSound%
    Reload
}

OnScriptActivation:
    main()
