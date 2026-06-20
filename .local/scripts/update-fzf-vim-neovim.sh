#!/usr/bin/env bash

set -Eeuo pipefail

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
fzf_src="$HOME/.fzf"

"$script_dir/update-neovim.sh"
"$script_dir/update-vim.sh"

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
