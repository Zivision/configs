#!/usr/bin/env sh

# Runs stow and loads folders into the .config dir
stow doom -t ~/.config/doom
stow home -t ~

# Copy desktop file over to xsessions
sudo cp ~/Workspace/Misc/configs/doom/exwm/exwm.desktop /usr/share/xsessions/
