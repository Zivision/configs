#!/usr/bin/env sh

# Dependances
#
# First update repos
sudo apt update

# General Dependances
sudo apt install stow -y

# DOOM Emacs requirements
sudo apt install emacs git ripgrep fd-find libjansson4 libjansson-dev -y
sudo apt install cmake libtool-bin -y  # For vterm
#
# Debugger requirements
sudo apt install build-essential gdb lldb cmake pkg-config -y
sudo apt install python3-debugpy -y # Python Debugger requirements
#
# adding the go debugger needs go first
# The command is
# go install github.com/go-delve/delve/cmd/dlv@latest
# as well as node js for the debugger

# Qtile
# Base depends
sudo apt install python3-cffi python3-cairocffi libpangocairo-1.0-0 pipx

# X11
sudo apt install python3-xcffib



# Installation
# Offical install instructions from:
# https://github.com/doomemacs/doomemacs?tab=readme-ov-file
# DOOM Emacs
#git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
#~/.config/emacs/bin/doom install

# qtile
pipx install qtile
