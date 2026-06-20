# Dotfiles

GNU Stow-based dotfiles for WSL/Linux.

## Cloning with submodules

```bash
git clone --recurse-submodules git@github.com:chrisgleitze/dotfiles.git ~/projects/dotfiles
```

If the repository is already cloned:

```bash
cd ~/projects/dotfiles
git submodule update --init --recursive
```

## Installation

Recommended bootstrap flow:

```bash
cd ~/projects/dotfiles
make bootstrap
```

With basic apt package installation first:

```bash
cd ~/projects/dotfiles
make bootstrap-with-packages
```

The bootstrap script updates submodules and always runs `stow --simulate` before the real Stow installation.

Manual Stow installation is also available:

```bash
cd ~/projects/dotfiles
make stow
```

Equivalent direct command:

```bash
stow --dir="$HOME/projects" --target="$HOME" dotfiles
```

## Removing symlinks

```bash
cd ~/projects/dotfiles
make unstow
```

Equivalent direct command:

```bash
stow --dir="$HOME/projects" --target="$HOME" --delete dotfiles
```

The previous repository was moved to `~/projects/dotfiles-old`.
