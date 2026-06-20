#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
target_dir="${TARGET:-$HOME}"
dry_run=0
yes=0
install_packages=0
skip_packages=0

apt_packages=(
  git
  stow
  curl
  zsh
  bash
  vim
  tmux
  ranger
  btop
)

usage() {
  cat <<USAGE
Usage: ./bootstrap.sh [options]

Bootstrap this dotfiles repository on WSL/Linux.

Options:
  -n, --dry-run           Only show package/submodule commands and run stow --simulate.
  -y, --yes               Do not ask before installing packages or running real stow.
      --install-packages  Install basic apt packages before stowing.
      --skip-packages     Do not install apt packages. This is the default.
      --target DIR        Stow target directory. Default: \$HOME or \$TARGET.
  -h, --help              Show this help.

USAGE
}

log() {
  printf '==> %s\n' "$*"
}

die() {
  printf 'Error: %s\n' "$*" >&2
  exit 1
}

confirm() {
  local prompt="$1"

  if (( yes )); then
    return 0
  fi

  if [[ ! -t 0 ]]; then
    die "$prompt Re-run with --yes to continue non-interactively."
  fi

  read -r -p "$prompt [y/N] " answer
  [[ "$answer" == [yY] || "$answer" == [yY][eE][sS] ]]
}

have() {
  command -v "$1" >/dev/null 2>&1
}

parse_args() {
  while (($#)); do
    case "$1" in
      -n|--dry-run)
        dry_run=1
        ;;
      -y|--yes)
        yes=1
        ;;
      --install-packages)
        install_packages=1
        skip_packages=0
        ;;
      --skip-packages)
        skip_packages=1
        install_packages=0
        ;;
      --target)
        shift
        [[ $# -gt 0 ]] || die "--target requires a directory"
        target_dir="$1"
        ;;
      --target=*)
        target_dir="${1#*=}"
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      --)
        shift
        (($# == 0)) || die "Unexpected arguments: $*"
        break
        ;;
      -*)
        die "Unknown option: $1"
        ;;
      *)
        die "Unexpected argument: $1"
        ;;
    esac
    shift
  done

  if (( install_packages && skip_packages )); then
    die "Use either --install-packages or --skip-packages, not both."
  fi
}

install_apt_packages() {
  (( install_packages )) || return 0

  if ! have apt-get; then
    die "apt-get not found. Install packages manually or run with --skip-packages."
  fi

  local missing=()
  local pkg
  for pkg in "${apt_packages[@]}"; do
    if ! dpkg-query -W -f='${Status}' "$pkg" 2>/dev/null | grep -q 'install ok installed'; then
      missing+=("$pkg")
    fi
  done

  if ((${#missing[@]} == 0)); then
    log "Required apt packages are already installed."
    return 0
  fi

  log "Missing apt packages: ${missing[*]}"

  if (( dry_run )); then
    printf 'Would run: sudo apt-get update\n'
    printf 'Would run: sudo apt-get install -y %s\n' "${missing[*]}"
    return 0
  fi

  confirm "Install missing apt packages with sudo apt-get?" || die "Package installation cancelled."

  sudo apt-get update
  sudo apt-get install -y "${missing[@]}"
}

update_submodules() {
  if [[ ! -d "$repo_dir/.git" ]]; then
    log "No .git directory found; skipping submodules."
    return 0
  fi

  if (( dry_run )); then
    printf 'Would run: git -C %q submodule update --init --recursive\n' "$repo_dir"
    return 0
  fi

  log "Updating git submodules."
  git -C "$repo_dir" submodule update --init --recursive
}

check_requirements() {
  have git || die "git is required. Install it manually or run with --install-packages."
  have stow || die "GNU Stow is required. Install it manually or run with --install-packages."
}

stow_dotfiles() {
  local stow_dir
  local stow_package
  stow_dir=$(dirname "$repo_dir")
  stow_package=$(basename "$repo_dir")
  local stow_args=(--dir="$stow_dir" --target="$target_dir" --verbose)

  log "Running stow simulation for: $stow_package"
  stow "${stow_args[@]}" --simulate "$stow_package"

  if (( dry_run )); then
    log "Dry run complete. No symlinks were changed."
    return 0
  fi

  confirm "Proceed with real stow installation?" || die "Stow installation cancelled."

  log "Running real stow installation."
  stow "${stow_args[@]}" "$stow_package"
}

main() {
  parse_args "$@"

  log "Repository: $repo_dir"
  log "Target: $target_dir"

  mkdir -p "$target_dir/.local/bin" "$target_dir/.local/scripts" "$target_dir/.config"

  install_apt_packages
  check_requirements
  update_submodules
  stow_dotfiles

  log "Bootstrap complete."
}

main "$@"
