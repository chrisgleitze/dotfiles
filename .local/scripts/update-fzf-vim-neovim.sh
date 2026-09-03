#!/usr/bin/env bash

set -Eeuo pipefail

fzf_src="$HOME/.fzf"
nvim_src="$HOME/src/neovim"
vim_src="$HOME/src/vim"
# existing nvim wrapper prefers this prefix before the /usr/local fallback
nvim_prefix="$HOME/.local/opt/nvim-linux-x86_64"
nvim_build_type="RelWithDebInfo"
# ~/.local/bin/vim points at this source-built install
vim_prefix="$HOME/.local/opt/vim-git"

# NEOVIM
# build only from the local Neovim master checkout
if [[ ! -d "$nvim_src/.git" ]]; then
  printf 'Not a Neovim Git checkout: %s\n' "$nvim_src" >&2
  exit 1
fi

# avoid overwriting local Neovim source edits during the pull/build
if ! git -C "$nvim_src" diff --quiet || ! git -C "$nvim_src" diff --cached --quiet; then
  printf 'Neovim source has local tracked changes: %s\n' "$nvim_src" >&2
  exit 1
fi

# update master, install it where ~/.local/bin/nvim will pick it up,
# then smoke-test startup
git -C "$nvim_src" pull --ff-only
if [[ -f "$nvim_src/build/CMakeCache.txt" ]] && ! grep -qx "CMAKE_BUILD_TYPE:STRING=$nvim_build_type" "$nvim_src/build/CMakeCache.txt"; then
  rm -f "$nvim_src/build/.ran-cmake"
fi
make -C "$nvim_src" CMAKE_BUILD_TYPE="$nvim_build_type" CMAKE_INSTALL_PREFIX="$nvim_prefix" install
"$nvim_prefix/bin/nvim" --version | head -3
nvim --version | head -3
XDG_STATE_HOME=/tmp/nvim-state XDG_CACHE_HOME=/tmp/nvim-cache nvim --headless -i NONE +qa

# build only from the local Vim master checkout
if [[ ! -d "$vim_src/.git" ]]; then
  printf 'Not a Vim Git checkout: %s\n' "$vim_src" >&2
  exit 1
fi

# avoid overwriting local Vim source edits during the pull/build
if ! git -C "$vim_src" diff --quiet || ! git -C "$vim_src" diff --cached --quiet; then
  printf 'Vim source has local tracked changes: %s\n' "$vim_src" >&2
  exit 1
fi

# VIM
# update master, rebuild with the same simple terminal setup,
# then expose it as ~/.local/bin/vim
git -C "$vim_src" pull --ff-only
make -C "$vim_src" distclean
cd "$vim_src"
./configure --prefix="$vim_prefix" --with-features=huge --disable-gui
make
make install
ln -sf "$vim_prefix/bin/vim" "$HOME/.local/bin/vim"
vim --version | head -5

# FZF
# fzf is updated from its own checkout after Vim and Neovim pass
if [[ ! -d "$fzf_src/.git" ]]; then
  printf 'Not an fzf Git checkout: %s\n' "$fzf_src" >&2
  exit 1
fi

if ! git -C "$fzf_src" diff --quiet || ! git -C "$fzf_src" diff --cached --quiet; then
  printf 'fzf source has local tracked changes: %s\n' "$fzf_src" >&2
  exit 1
fi

git -C "$fzf_src" pull --ff-only
"$fzf_src/install" --all
