#NoTrayIcon

; This script maps some keyboard combinations (latam layout)
; preceded by AltGr to combinations I use on Linux:
;   hjklio to navigation keys,
;   <> to parenthesis,
;   Special characters (caret, backtick, tilde, at sign).

; Detect if AltGr is pressed
LControl & RAlt:: AltGR = 1
LControl & RAlt Up:: AltGR = 0

#If AltGR = 1

; Standalone
h:: Send {Left}
j:: Send {Down}
k:: Send {Up}
l:: Send {Right}
i:: Send {Home}
o:: Send {End}

; Shift +
+h:: Send +{Left}
+j:: Send +{Down}
+k:: Send +{Up}
+l:: Send +{Right}
+i:: Send +{Home}
+o:: Send +{End}

; Ctrl +
^h:: Send ^{Left}
^j:: Send ^{Down}
^k:: Send ^{Up}
^l:: Send ^{Right}
^i:: Send ^{Home}
^o:: Send ^{End}

; Ctrl + Shift +
^+h:: Send ^+{Left}
^+j:: Send ^+{Down}
^+k:: Send ^+{Up}
^+l:: Send ^+{Right}
^+i:: Send ^+{Home}
^+o:: Send ^+{End}

; Ctrl + Alt +
^!h:: Send ^!{Left}
^!j:: Send ^!{Down}
^!k:: Send ^!{Up}
^!l:: Send ^!{Right}
^!i:: Send ^!{Home}
^!o:: Send ^!{End}

; Ctrl + Super +
^#h:: Send ^!{Left}
^#j:: Send ^!{Down}
^#k:: Send ^!{Up}
^#l:: Send ^!{Right}
^#i:: Send ^!{Home}
^#o:: Send ^!{End}

; Shift + Super +
+#h:: Send ^!{Left}
+#j:: Send ^!{Down}
+#k:: Send ^!{Up}
+#l:: Send ^!{Right}
+#i:: Send ^!{Home}
+#o:: Send ^!{End}

; Map altGr + <> to parenthesis
<:: Send {(}
>:: Send {)}

; Restore special characters I use frequently
{:: Send {^}
}:: Send {``}
+:: Send {~}
q:: Send {@}
':: Send {\}

#If
