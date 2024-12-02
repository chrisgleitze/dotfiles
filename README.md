# dotfiles

My dotfiles on my Windows machine and in my WSL (Windows Subsystem for Linux).

You find my Neovim config in [a separate repo](https://github.com/chrisgleitze/neovim-config).

## Setting up a WSL

This is not a detailed instruction but rather a to-do list for me when I set up a new WSL distro. See the [WSL folder in this repo](/WSL) for the config files I use in my Linux distros.

install WSL distro

install and configure zsh

set bashrc to zsh

setup ohmyzsh

install tools:\
fzf, fd, ripgrep, git, lazygit, nvm, node (which includes npm)

configure git

setup ssh to connect to GitHub

install and configure tmux

install LazyVim (Neovim distribution), add my config

## Memo re common WSL/Ubuntu bugs

Change permission for SSH key.
Run this command, so only you can read your SSH key:
chmod 600 ~/.ssh/id_rsa

Error after installing Neovim in Ubuntu WSL:
"No C compiler found! "cc", "gcc", "clang", "cl", "zig" are not executable."
Quit Neovim, run this command:
sudo apt update && sudo apt install build-essential
