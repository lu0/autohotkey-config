#NoTrayIcon
#SingleInstance Force

; This scripts maps PgUp, Up and PgDn to media keys (prev track, play/pause, next track).
;
; Those 3 keys are aligned in the Thinkpad Trackpoint Keyboard,
; The Up arrow is already mapped to AltGr + k in altgr-arrows-and-chars.ahk;
; and I don't use PgUp and PgDn, so I won't miss them.

PgUp::Media_Prev
Up::Media_Play_Pause
PgDn::Media_Next
