#NoTrayIcon
#SingleInstance Force

; This scripts maps ctrl + alt + <letter> to the programs I use frequently.

; Files (File Manager)
; ctrl + alt + f
^!f::
    Run files
return


; WSL (Terminal)
; ctrl + alt + t
^!t::
    Run wsl
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


; Outlook Mail
; ctrl + alt + m
^!m::
    Run outlook
return


; Microsoft Teams
; ctrl + alt + shift + m
^!+m::
    Run C:\Users\%A_UserName%\AppData\Local\Microsoft\Teams\Update.exe --processStart "Teams.exe"
return
