# dotfiles

My dotfiles on my Windows machine and in my WSL (Windows Subsystem for Linux).

You find my Neovim config in [a separate repo](https://github.com/chrisgleitze/init.lua).

## Setting up a WSL

This is not a detailed instruction but rather a to-do list for me when I set up a new WSL distro. See the [WSL folder in this repo](/WSL) for the config files I use in my Linux distros.

install WSL distro

install and configure zsh

set bashrc to zsh

setup ohmyzsh

install tools:\
fzf, fd, ripgrep, git, lazygit, nvm, nodejs (which includes npm), zip, unzip, keychain (checks for running ssh-agent)

add completion.zsh and key-bindings.zsh scripts to .fzf/shell/

configure git

setup ssh to connect to GitHub
test with
`ssh -T git@github.com`

install and configure tmux

install Neovim, add my LazyVim config

## Memo re common WSL/Ubuntu bugs

To get necessary permissions to work with folders (e.g. to cd, ll etc.) and files, you might need these commands:\
`sudo chmod -R a+rwx foldername`\
`sudo chmod a+rwx filename`

Change permission for SSH key.\
Run this command, so only you can read your SSH key:\
`chmod 600 ~/.ssh/id_rsa`

Check if ssh connection to GitHub works:\
`ssh -T git@github.com`\
Should return "Hi {username}! You've successfully authenticated ..."

Error "fatal: could not create work tree dir ...: permission denied" might not have anything to do with the WSL git config but that you didn't give yourself permission to write/create in your coding projects folder. So, do this:\
`sudo chmod 777 /home/username/projects`

Lazygit "Error gettign repo paths ... fatal: detected dubious ownership in repo ..."\
Lazygit installation might be perfectly fine. It's just that the write/create permission is missing to open Lazygit. See above!\

Error after installing Neovim in Ubuntu WSL:\
"No C compiler found! "cc", "gcc", "clang", "cl", "zig" are not executable."\
Quit Neovim, run this command:\
`sudo apt update && sudo apt install build-essential`

## Windows

install fzf, fd, ripgrep, git, lazygit, nvm, nodejs (which includes npm)

install ohmyposh

install nerdfonts via ohmyposh, select font

install PSReadLine

install PSFzf

change paths in Powershell profile and settings.json (e.g. path in aliases and in oh-my-posh init pwsh --config)

install Alacritty

in Alacritty change to WSL using Neovim in tmux ;-)
