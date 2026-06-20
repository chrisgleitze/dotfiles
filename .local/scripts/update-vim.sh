#!/usr/bin/env bash

set -Eeuo pipefail

vim_src="$HOME/.local/src/vim"

if [[ -e "$vim_src" && ! -d "$vim_src/.git" ]]; then
  printf 'Not a Git checkout: %s\n' "$vim_src" >&2
  exit 1
fi

if [[ ! -d "$vim_src/.git" ]]; then
  mkdir -p "$(dirname "$vim_src")"
  git clone --filter=blob:none https://github.com/vim/vim.git "$vim_src"
elif ! git -C "$vim_src" diff --quiet || ! git -C "$vim_src" diff --cached --quiet; then
  printf 'Vim source has local tracked changes: %s\n' "$vim_src" >&2
  exit 1
else
  git -C "$vim_src" pull --ff-only
fi

make -C "$vim_src/src" -j"$(nproc)"
sudo make -C "$vim_src/src" install

printf 'Installed Vim from %s\n' "$(git -C "$vim_src" rev-parse --short HEAD)"
vim --version | sed -n '1,3p'
