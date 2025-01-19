# dotfiles

My dotfiles on my Windows machine and in my WSL (Windows Subsystem for Linux).

You find my Neovim config in [a separate repo](https://github.com/chrisgleitze/nvim).

## Setting up a WSL

This is not a detailed instruction but rather a to-do list for me when I set up a new WSL distro. See the [WSL folder in this repo](/WSL) for the config files I use in my Linux distros.

install WSL distro

install and configure zsh

set bashrc to zsh

setup ohmyzsh

install tools:\
fzf, fd, ripgrep, git, lazygit, nvm, nodejs (which includes npm), zip, unzip, keychain (checks for running ssh-agent)

configure git

setup ssh to connect to GitHub

install and configure tmux

install LazyVim (Neovim distribution), add my config

## Memo re common WSL/Ubuntu bugs

Change permission for SSH key.\
Run this command, so only you can read your SSH key:\
`chmod 600 ~/.ssh/id_rsa`

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
