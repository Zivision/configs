{ config, lib, pkgs, ... }:

{
  home.username = "primary";
  home.homeDirectory = "/home/primary";
  home.stateVersion = "25.11";

# Start of the home packages array
home.packages = with pkgs; [
brave

# User fonts
nerd-fonts.symbols-only
nerd-fonts.iosevka

# Symlink manager
stow
];
}
