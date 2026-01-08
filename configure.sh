#!/usr/bin/env sh

# Runs stow and loads folders into the .config dir
stow doom -t ~/.config/doom
stow qtile -t ~/.config/qtile
stow home -t ~
stow picom -t ~/.config/picom

# link certain files
ln -s ~/Workspace/Misc/configs/stumpwm/init.lisp ~/.config/stumpwm/config
ln -s ~/Workspace/Misc/configs/stumpwm/autostart.sh ~/.config/stumpwm/autostart.sh

# Copy desktop file over to xsessions
#sudo cp qtile/qtile.desktop /usr/share/xsessions/
