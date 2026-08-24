{ config, lib, pkgs, ... }:

{
  home.username = "primary";
  home.homeDirectory = "/home/primary";
  home.stateVersion = "26.05";

home.file = {

".config/kitty" = {
  source = ../kitty;
  recursive = true;
};

".config/waybar" = {
  source = ../waybar;
  recursive = true;
};

".config/wofi" = {
  source = ../wofi;
  recursive = true;
};

".config/sway" = {
  source = ../sway;
  recursive = true;
};

".config/swaylock" = {
  source = ../swaylock;
  recursive = true;
};

".config/mako" = {
  source = ../mako;
  recursive = true;
};

".config/foot" = {
  source = ../foot;
  recursive = true;
};

".config/kwalletrc".text = ''
  [Wallet]
  Enabled=true
'';

};

services.nextcloud-client = {
  enable = true;
  startInBackground = true;
};

home.packages = with pkgs; [

libreoffice-qt6-fresh

(prismlauncher.override {
  jdks = [

    zulu25
    zulu8
  ];
})

wl-clipboard
mako
swaybg
wofi
waybar
waypaper

# Start of the home packages array
firefox

# Backup Editor
vscode

kdePackages.kdenlive

audacity

# Chinese Font
noto-fonts-cjk-sans
noto-fonts-cjk-serif

kitty

];
 }
