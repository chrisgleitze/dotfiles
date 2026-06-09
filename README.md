# Dotfiles

GNU Stow-based dotfiles for WSL/Linux.

## Structure

Each directory in this repository is a Stow package and mirrors paths relative to `$HOME`:

- `zsh` → `~/.zshrc`, `~/.zsh/functions/...`
- `bash` → `~/.bashrc`
- `vim` → `~/.vimrc`
- `git` → `~/.gitconfig`
- `tmux` → `~/.tmux.conf`
- `local-bin` → `~/.local/bin/nvim`
- `scripts` → helper scripts in `~/.local/bin/`
- `ranger` → `~/.config/ranger/rc.conf`
- `btop` → `~/.config/btop/btop.conf`
- `lazygit` → `~/.config/lazygit/config.yml`

## Installation

```bash
cd ~/projects/dotfiles
stow --target="$HOME" zsh bash vim git tmux local-bin scripts ranger btop lazygit
```

## Removing symlinks

```bash
cd ~/projects/dotfiles
stow --target="$HOME" --delete zsh bash vim git tmux local-bin scripts ranger btop lazygit
```

The previous repository was moved to `~/projects/dotfiles-old`.
