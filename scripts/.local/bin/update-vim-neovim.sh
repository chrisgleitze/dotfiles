#!/usr/bin/env bash

cd
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz
tar xzvf nvim-linux-x86_64.tar.gz
sudo rm -rf nvim-linux-x86_64.tar.gz
sudo rm -rf /usr/local/bin/nvim-linux-x86_64
sudo mv nvim-linux-x86_64 /usr/local/bin
cd ~/.vim
git pull
cd src
make
sudo make install
