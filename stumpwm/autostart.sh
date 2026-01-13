#!/usr/bin/bash

# Start Picom
picom &

# Nitrogen
nitrogen --restore &

# polybar
polybar &

# Polkit (Gnome)
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
