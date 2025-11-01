#!/usr/bin/env sh

# Configure Doom emacs
#
# Dependances
#
# First update repos
sudo apt update

# Doom emacs requirements
sudo apt install emacs git ripgrep

# Vterm requirements (uncomment if wanted)
# sudo apt install cmake libtool-bin



# Installation
# Offical install instructions from:
# https://github.com/doomemacs/doomemacs?tab=readme-ov-file
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
