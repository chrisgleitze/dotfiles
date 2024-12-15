$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

oh-my-posh init pwsh --config 'C:\Users\asus\AppData\Local\Programs\oh-my-posh\themes\jblab_2021_mine.omp.json' | Invoke-Expression

# PSREADLINE
Import-Module PSReadLine

#Fzf - FUZZY FINDER
Import-Module PSFzf

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+o'
# Alt-c for change directory fuzzy finder
# Ctrl-r is for bck-i-search
# Ctrl-s is for fwd-i-search

# file preview for fuzzy finder
function pv { fzf --preview='bat --color=always --style=numbers {}' }

Set-PSReadLineOption -PredictionSource History

Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-PSReadLineKeyHandler -Key Tab -Function Complete

Set-PSReadLineKeyHandler -Chord Ctrl-a -Function BeginningOfLine
Set-PSReadLineKeyHandler -Chord Ctrl-e -Function EndOfLine

# ALIASES
Set-Alias ll ls
Set-Alias c clear
function .. { cd .. }
function cdnvim { set-location "C:\Users\asus\AppData\Local\nvim" }
function cdproj { set-location "C:\Users\asus\Documents\Github" }

# GIT ALIASES
Set-Alias g git 
function gb { git branch }
function gl { git log }
function gs { git status }
function ga { git add .}
function gaa { git add --all }
function gc { git commit }
function gcc { git commit -m "xxx" }
function gco { git checkout }
function gpu { git push }
