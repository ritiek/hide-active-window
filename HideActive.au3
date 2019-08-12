#NoTrayIcon
#include <Misc.au3>

If _Singleton(@ScriptName, 1) = 0 Then
    Exit
EndIf

HotKeySet("{F8}", "HideShow")
HotKeySet("{F10}", "Suspend")
HotKeySet("{F11}", "ExitScript")

$Value = 0
$Suspend = False

Func Suspend()
    $Suspend = Not $Suspend
    If $Suspend = True Then
        ToolTip("Suspend", 0, 0)
        HotKeySet("{F8}")
        HotKeySet("{F11}")
    Else
        ToolTip("Activate", 0, 0)
        HotKeySet("{F8}", "HideShow")
        HotKeySet("{F11}", "ExitScript")
    EndIf
    Sleep(300)
    ToolTip("")
EndFunc


Func HideShow()
    If $Value = 0 Then
        ToolTip("HideWindow", 0, 0)
        HideWindow()
    ElseIf $Value = 1 Then
        ToolTip("ShowWindow", 0, 0)
        ShowWindow()
    EndIf
    Sleep(100)
    ToolTip("")
EndFunc


Func HideWindow()
    Global $Handle = WinGetHandle("", "")
    WinSetState($Handle, "", @SW_HIDE)
    $Value = 1
EndFunc


Func ShowWindow()
    WinSetState($Handle, "", @SW_SHOW)
    WinActivate($Handle)
    $Value = 0
EndFunc


Func ExitScript()
   If $Value = 1 Then
      WinClose($Handle)
   EndIf
   Exit
EndFunc


While 1
    If $Suspend = 0 Then
        $Pos = MouseGetPos()
        If $Pos[0] = 0 And $Pos[1] = 0 Then
            HideShow()
        EndIf
        If $Pos[0] = (@DesktopWidth - 1) And $Pos[1] = (@DesktopHeight - 1) Then
            ExitScript()
        EndIf
    EndIf
    Sleep(20)
WEnd
