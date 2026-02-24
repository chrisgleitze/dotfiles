#!/usr/bin/env bash

wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz
tar xzvf nvim-linux-x86_64.tar.gz
sudo rm -rf nvim-linux-x86_64.tar.gz
sudo rm -rf /usr/local/bin/nvim-linux-x86_64
sudo mv nvim-linux-x86_64 /usr/local/bin
