{ config, lib, pkgs, ... }:

{
  home.username = "primary";
  home.homeDirectory = "/home/primary";
  home.stateVersion = "25.11";

programs.direnv = {
  enable = true;
  nix-direnv.enable = true;
};

home.file = {

".local/bin/manage-system" ={
  source = ../../bin/manage-system;
  executable = true;
};
# Legacy Script that will be replaced eventually
".local/bin/update-system" ={
  source = ../../bin/update-system;
  executable = true;
};

".config/doom" = {
  source = ../doom;
  recursive = true;
};

".config/hypr" = {
  source = ../hypr;
  recursive = true;
};

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

};

programs.bash = {
    enable = true;
    initExtra = builtins.readFile ../home/.bashrc;

    sessionVariables = {
      EDITOR = "nvim";
    };
  };

home.packages = with pkgs; [

(prismlauncher.override {
  jdks = [
    zulu25
  ];
})

hyprpaper
wofi
waybar

waypaper
brightnessctl

# Start of the home packages array
brave

# For Emacs
  python3
  gcc
  gnumake
  ripgrep
  fd
  emacs-pgtk
  cmake
  libtool
  ispell
  # emacs itself
  emacs-pgtk

  # Org mode
  graphviz

  # MPV for emms
  mpv
  # Neovim for quick edits
  neovim

  # Nix format
  nixfmt

  # Shell stuff
  shellcheck
  shfmt

fastfetch
  git
  curl
  wget
  htop
  stow
  fzf
  findutils.locate
  texlive.combined.scheme-medium

# Fonts for emacs
nerd-fonts.symbols-only
nerd-fonts.iosevka

# Chinese Font
noto-fonts-cjk-sans
noto-fonts-cjk-serif

kitty

];
 }
