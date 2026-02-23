{ config, lib, pkgs, ... }:

{
  home.username = "primary";
  home.homeDirectory = "/home/primary";
  home.stateVersion = "25.11";

services.hyprpaper = {
  enable = true;
  settings = {
    preload = [
      "~/Pictures/abstract_flute.png"
      "~/Pictures/art-deco-acid-trip.png"
    ];
    wallpaper = [
      # By display
      "HDMI-A-1,~/Pictures/abstract_flute.png"
      "DP-2,~/Pictures/art-deco-acid-trip.png"
    ];
  };
};

# Start of the home packages array
home.packages = with pkgs; [
  brave
];
}
