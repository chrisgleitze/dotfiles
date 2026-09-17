#Requires AutoHotkey v2.0
#SingleInstance Force

CapsLock::Escape
$<^>!Tab::Send "{Blind}{Ctrl Up}{RAlt Up}{LAlt Down}{Tab}{LAlt Up}"

FocusOrRun(winTitle, runTarget) {
    if hwnd := WinExist(winTitle)
        WinActivate "ahk_id " hwnd
    else
        Run runTarget
}

F13::FocusOrRun("ahk_exe alacritty.exe", "C:\Program Files\Alacritty\alacritty.exe")
F14::FocusOrRun("ahk_exe chrome.exe", "C:\Program Files\Google\Chrome\Application\chrome.exe")
F15::FocusOrRun("ahk_class CabinetWClass", "explorer.exe")
F16::FocusOrRun("ahk_exe OUTLOOK.EXE", "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE")
F17::FocusOrRun("ahk_exe WhatsApp.exe", "explorer.exe shell:AppsFolder\5319275A.WhatsAppDesktop_cv1g1gvanyjgm!App")
F18::FocusOrRun("ahk_exe Signal.exe", "C:\Users\Christian\AppData\Local\Programs\signal-desktop\Signal.exe")
F19::FocusOrRun("ahk_exe notepad.exe", "notepad.exe")
F20::FocusOrRun("ahk_exe Acrobat.exe", "C:\Program Files\Adobe\Acrobat DC\Acrobat\Acrobat.exe")
F21::SendText "😅"
F22::SendText "😂"
F23::SendText "😉"
