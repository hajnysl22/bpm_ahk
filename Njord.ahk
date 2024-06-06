#Requires AutoHotkey v2.0

; Process name of the game
processName := "BPMGame-Win64-Shipping.exe"

; Function to check if game is active
isGameActive()
{
    global processName
    ; Get ID of the active window
    activeWindow := WinGetID("A")
    if activeWindow {
        ; Process ID of the active window
        processID := WinGetPID("ahk_id " activeWindow)
        ; Process name from the process ID
        processNameActive := ProcessGetName(processID)
        return (processNameActive = processName)
    }
    return false
}

; Njord
; Use Q to activate Auto-shoot + Auto-reload
q:: {
    if isGameActive() {
        static toggle := 0
        toggle := !toggle
        if toggle {
            ; Use Secondary ability
            if GetKeyState("RButton", "P") {
                SetTimer Click, 0
                Send("{RButton down}{RButton up}")
            }
            ; Use Dash ability
            if GetKeyState("LShift", "P") {
                SetTimer Click, 0
                Send("{LShift down}{LShift up}")
            }
            ; Use Ultimate ability
            if GetKeyState("e", "P") {
                SetTimer Click, 0
                Send("{e down}{e up}")
            } else {
                Loop {
                    ; Shoot
                    Send("{LButton}")
                    Sleep 338
                }
            }
        } else {
            SetTimer Click, 0
        }
        return
    }
}

; Toggle script suspend with XButton1
; Toggle script pause with x
#SuspendExempt
XButton1::Suspend
x::Pause -1
#SuspendExempt False