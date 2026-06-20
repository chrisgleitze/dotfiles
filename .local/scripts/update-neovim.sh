#!/usr/bin/env bash

set -Eeuo pipefail

asset_name='nvim-linux-x86_64.tar.gz'
api_url='https://api.github.com/repos/neovim/neovim/releases/tags/nightly'
install_dir='/usr/local/bin/nvim-linux-x86_64'
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

curl -fsSL --retry 3 "$api_url" -o "$tmp/release.json"
mapfile -t asset < <(python3 - "$tmp/release.json" "$asset_name" <<'PY'
import json
import sys

release_path, asset_name = sys.argv[1:]
with open(release_path, encoding='utf-8') as release_file:
    release = json.load(release_file)

for asset in release.get('assets', []):
    if asset.get('name') == asset_name:
        print(asset['browser_download_url'])
        print(asset.get('digest', ''))
        break
else:
    raise SystemExit(f'Nightly asset not found: {asset_name}')
PY
)

if [[ ${#asset[@]} -ne 2 || ${asset[1]} != sha256:* ]]; then
  printf 'No SHA-256 digest published for %s\n' "$asset_name" >&2
  exit 1
fi

archive="$tmp/$asset_name"
curl -fL --retry 3 "${asset[0]}" -o "$archive"
printf '%s  %s\n' "${asset[1]#sha256:}" "$archive" | sha256sum --check --status
tar -xzf "$archive" -C "$tmp"

extracted="$tmp/nvim-linux-x86_64"
"$extracted/bin/nvim" --version >/dev/null

staging="${install_dir}.new"
backup="${install_dir}.old"
sudo rm -rf "$staging" "$backup"
sudo cp -a "$extracted" "$staging"

if [[ -e "$install_dir" ]]; then
  sudo mv "$install_dir" "$backup"
fi

if ! sudo mv "$staging" "$install_dir"; then
  [[ ! -e "$backup" ]] || sudo mv "$backup" "$install_dir"
  exit 1
fi

sudo rm -rf "$backup"
"$install_dir/bin/nvim" --version | sed -n '1,3p'
