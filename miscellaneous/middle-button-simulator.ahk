#NoTrayIcon
#SingleInstance Force

; This script emulates a middle click on non-ThinkPad keyboards after
; pressing the Right Button of the touchpad for more than 200 ms.
;
; This is specially useful when a pointing stick/trackpoint is present,
; but not a middle button on the touchpad.

$RButton::
    ; Wait up to 200 ms to release the Right Button
	KeyWait, RButton, T0.2
	if (ErrorLevel) {
        ; Emulate a Middle Click if the RButton wasn't released
        Send, {MButton}
    } else {
        ; If the RButton was released within 200 ms,
        ; send a Right Click and exit the script
        Send, {RButton}
        return
	}
    
    ; Wait for the RButton (now Middle Click) to be released,
    KeyWait, RButton

    ; Stop scrolling
    Send, {Esc}
    return

