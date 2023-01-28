#Requires AutoHotKey >=2.0

Joy1::
{
    Send "{a down}"
    KeyWait "Joy1"
    Send "{a up}"
}
Joy2::
{
    Send "{s down}"
    KeyWait "Joy2"
    Send "{s up}"
}
Joy11::
{
    Send "{w down}"
    KeyWait "joy11"
    Send "{w up}"
}
Joy12::
{
    Send "{Enter down}"
    KeyWait "Joy12"
    Send "{Enter up}"
}

SetTimer WatchPOV, 5

KeyToHoldDown := ""

WatchPOV()
{
    global KeyToHoldDown
    POV := GetKeyState("JoyPOV")  ; Get position of the POV control.
    KeyToHoldDownPrev := KeyToHoldDown  ; Prev now holds the key that was down before (if any).

    ; Some joysticks might have a smooth/continous POV rather than one in fixed increments.
    ; To support them all, use a range:
    if POV = ""
        KeyToHoldDown := ""
    else if POV < 0   ; No angle to report
        KeyToHoldDown := ""
    else if POV = 0
        KeyToHoldDown := "Up"
    else if POV = 9000
        KeyToHoldDown := "Right"
    else if POV = 18000
        KeyToHoldDown := "Down"
    else if POV = 27000
        KeyToHoldDown := "Left"

    if (KeyToHoldDown != KeyToHoldDownPrev) {
        ; release the previous key and press down the new key:
        SetKeyDelay -1  ; Avoid delays between keystrokes.
        if KeyToHoldDownPrev   ; There is a previous key to release.
            Send "{" KeyToHoldDownPrev " up}"
        if KeyToHoldDown   ; There is a key to press down.
            Send "{" KeyToHoldDown " down}"
    }
}