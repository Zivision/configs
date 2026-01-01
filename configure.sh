#!/usr/bin/env sh

# Runs stow and loads folders into the .config dir
stow doom -t ~/.config/doom
stow qtile -t ~/.config/qtile
stow home -t ~

# Copy desktop file over to xsessions
sudo cp qtile/qtile.desktop /usr/share/xsessions/
