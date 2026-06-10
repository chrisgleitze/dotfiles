SHELL := /bin/bash

TARGET ?= $(HOME)
STOW_PACKAGES ?= zsh bash vim git tmux local-bin scripts ranger btop lazygit nvim
APT_PACKAGES ?= git stow curl zsh bash vim tmux ranger btop

.PHONY: help bootstrap bootstrap-with-packages packages submodules stow-simulate stow unstow restow check

help:
	@printf '%s\n' 'Dotfiles targets:'
	@printf '%s\n' '  make bootstrap                Run bootstrap without apt package installation.'
	@printf '%s\n' '  make bootstrap-with-packages  Install apt packages, update submodules, then stow.'
	@printf '%s\n' '  make packages                 Install basic apt packages.'
	@printf '%s\n' '  make submodules               Initialize/update git submodules.'
	@printf '%s\n' '  make stow-simulate            Run GNU Stow simulation only.'
	@printf '%s\n' '  make stow                     Simulate first, then stow dotfiles.'
	@printf '%s\n' '  make unstow                   Remove stow symlinks.'
	@printf '%s\n' '  make restow                   Restow dotfiles.'
	@printf '%s\n' '  make check                    Show git status and run stow simulation.'
	@printf '%s\n' ''
	@printf '%s\n' 'Variables:'
	@printf '%s\n' '  TARGET=/path       Stow target directory. Default: $$HOME.'
	@printf '%s\n' '  STOW_PACKAGES=...  Override selected Stow packages.'

bootstrap:
	./bootstrap.sh --skip-packages --yes --target "$(TARGET)" $(STOW_PACKAGES)

bootstrap-with-packages:
	./bootstrap.sh --install-packages --yes --target "$(TARGET)" $(STOW_PACKAGES)

packages:
	sudo apt-get update
	sudo apt-get install -y $(APT_PACKAGES)

submodules:
	git submodule update --init --recursive

stow-simulate:
	stow --dir=$(CURDIR) --target="$(TARGET)" --simulate --verbose $(STOW_PACKAGES)

stow:
	stow --dir=$(CURDIR) --target="$(TARGET)" --simulate --verbose $(STOW_PACKAGES)
	stow --dir=$(CURDIR) --target="$(TARGET)" --verbose $(STOW_PACKAGES)

unstow:
	stow --dir=$(CURDIR) --target="$(TARGET)" --delete --verbose $(STOW_PACKAGES)

restow:
	stow --dir=$(CURDIR) --target="$(TARGET)" --restow --verbose $(STOW_PACKAGES)

check:
	git status --short
	stow --dir=$(CURDIR) --target="$(TARGET)" --simulate --verbose $(STOW_PACKAGES)
