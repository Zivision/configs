{ config, lib, pkgs, ... }:

{
  home.username = "primary";
  home.homeDirectory = "/home/primary";
  home.stateVersion = "25.11";

programs.direnv = {
  enable = true;
  nix-direnv.enable = true;
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
