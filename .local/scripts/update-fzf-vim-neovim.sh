#!/usr/bin/env bash

set -Eeuo pipefail

fzf_src="$HOME/.fzf"
nvim_src="$HOME/src/neovim"
# existing nvim wrapper prefers this prefix before the /usr/local fallback
nvim_prefix="$HOME/.local/opt/nvim-linux-x86_64"

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
make -C "$nvim_src" CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX="$nvim_prefix" install
"$nvim_prefix/bin/nvim" --version | head -3
nvim --version | head -3
XDG_STATE_HOME=/tmp/nvim-state XDG_CACHE_HOME=/tmp/nvim-cache nvim --headless -i NONE +qa

# fzf is updated from its own checkout after Neovim passes the smoke test
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
