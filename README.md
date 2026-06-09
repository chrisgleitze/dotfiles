# Dotfiles

GNU-Stow-basierte Dotfiles für WSL/Linux.

## Struktur

Jeder Ordner im Repository ist ein Stow-Package und spiegelt Pfade relativ zu `$HOME`:

- `zsh` → `~/.zshrc`, `~/.zsh/functions/...`
- `bash` → `~/.bashrc`
- `vim` → `~/.vimrc`
- `git` → `~/.gitconfig`
- `tmux` → `~/.tmux.conf`
- `local-bin` → `~/.local/bin/nvim`
- `scripts` → Hilfsskripte unter `~/.local/bin/`
- `ranger` → `~/.config/ranger/rc.conf`
- `btop` → `~/.config/btop/btop.conf`
- `lazygit` → `~/.config/lazygit/config.yml`

## Installation

```bash
cd ~/projects/dotfiles
stow --target="$HOME" zsh bash vim git tmux local-bin scripts ranger btop lazygit
```

## Entfernen der Symlinks

```bash
cd ~/projects/dotfiles
stow --target="$HOME" --delete zsh bash vim git tmux local-bin scripts ranger btop lazygit
```

Das vorherige Repository wurde nach `~/projects/dotfiles-old` verschoben.
Die vor der Stow-Umstellung vorhandenen echten Dateien wurden in einem Backup unter `$HOME/.dotfiles-pre-stow-backup-*` gesichert.
