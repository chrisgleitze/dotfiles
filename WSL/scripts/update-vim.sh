#!/usr/bin/env bash

cd ~/.vim
git pull
cd src
make
sudo make install
