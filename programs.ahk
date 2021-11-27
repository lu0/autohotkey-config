#NoTrayIcon
#SingleInstance Force

; This scripts maps ctrl + alt + <letter> to the programs I use frequently.

; Files (File Manager)
; ctrl + alt + f
^!f::
    Run files
return



; Vivaldi (web browser)
; ctrl + alt + w
^!w::
    Run vivaldi
return


; Visual Studio Code
; ctrl + alt + v
^!v::
    Run code
return


; Thunderbird Mail
; ctrl + alt + m
^!m::
    Run C:\Program Files\Mozilla Thunderbird\thunderbird.exe
return


; Microsoft Teams
; ctrl + alt + shift + m
^!+m::
    Run C:\Users\%A_UserName%\AppData\Local\Microsoft\Teams\Update.exe --processStart "Teams.exe"
return
