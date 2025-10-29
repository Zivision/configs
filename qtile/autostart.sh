#!/usr/bin/bash

# Start Picom
picom &

# Nitrogen
nitrogen --restore &

# Polkit (Gnome)
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
