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
#
# XMonad can be installed from ubuntu repos via
# sudo apt install xmonad libghc-xmonad-contrib-dev
#
# How ever I like writing haskell so I usually install GHCup anyway so for that:
# GHCup requirements
sudo apt install build-essential curl libffi-dev libgmp-dev libgmp10 libncurses-dev
# Xmonad requirements (Might not all be required but it was the only way I could get it to compile)
sudo apt install libx11-dev libxft-dev libxinerama-dev libxrandr-dev libxss-dev libasound2-dev

# And other apps for xmonad
sudo apt install rofi nitrogen picom

# Installation
# Offical install instructions from:
# https://github.com/doomemacs/doomemacs?tab=readme-ov-file
#
# git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
# ~/.config/emacs/bin/doom install
#
# Install GHCup
# Command source: https://www.haskell.org/ghcup/
#
# curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
