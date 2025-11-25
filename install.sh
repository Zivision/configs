#!/usr/bin/env sh

# Dependances
#
# First update repos
sudo apt update

# General Dependances
sudo apt install stow

# DOOM Emacs requirements
sudo apt install emacs git ripgrep \
cmake libtool-bin # For vterm

# Installation
# Offical install instructions from:
# https://github.com/doomemacs/doomemacs?tab=readme-ov-file
# DOOM Emacs
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
