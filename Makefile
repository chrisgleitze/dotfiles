SHELL := /bin/bash

TARGET ?= $(HOME)
STOW_DIR := $(abspath $(CURDIR)/..)
STOW_PACKAGE := $(notdir $(CURDIR))
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

bootstrap:
	./bootstrap.sh --skip-packages --yes --target "$(TARGET)"

bootstrap-with-packages:
	./bootstrap.sh --install-packages --yes --target "$(TARGET)"

packages:
	sudo apt-get update
	sudo apt-get install -y $(APT_PACKAGES)

submodules:
	git submodule update --init --recursive

stow-simulate:
	stow --dir="$(STOW_DIR)" --target="$(TARGET)" --simulate --verbose "$(STOW_PACKAGE)"

stow:
	stow --dir="$(STOW_DIR)" --target="$(TARGET)" --simulate --verbose "$(STOW_PACKAGE)"
	stow --dir="$(STOW_DIR)" --target="$(TARGET)" --verbose "$(STOW_PACKAGE)"

unstow:
	stow --dir="$(STOW_DIR)" --target="$(TARGET)" --delete --verbose "$(STOW_PACKAGE)"

restow:
	stow --dir="$(STOW_DIR)" --target="$(TARGET)" --restow --verbose "$(STOW_PACKAGE)"

check:
	git status --short
	stow --dir="$(STOW_DIR)" --target="$(TARGET)" --simulate --verbose "$(STOW_PACKAGE)"
