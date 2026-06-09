{ config, lib, pkgs, ... }:

{
  home.username = "primary";
  home.homeDirectory = "/home/primary";
  home.stateVersion = "26.05";

programs.direnv = {
  enable = true;
  nix-direnv.enable = true;
};

home.file = {

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

".config/sway" = {
  source = ../sway;
  recursive = true;
};

".config/swaylock" = {
  source = ../swaylock;
  recursive = true;
};

".config/kwalletrc".text = ''
  [Wallet]
  Enabled=false
'';

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
    zulu8
  ];
})

hyprpaper
wofi
waybar

waypaper
brightnessctl

wl-clipboard
mako
swaybg

# Start of the home packages array
brave

# For Emacs
  python3
  gcc
  gnumake
  ripgrep
  fd
  cmake
  libtool
  ispell
  # emacs itself
  ((emacsPackagesFor emacs-pgtk).emacsWithPackages (epkgs: [
    epkgs.mu4e
  ]))
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
  fzf
  findutils.locate
  yt-dlp

# Fonts for emacs
nerd-fonts.symbols-only
nerd-fonts.iosevka

# Chinese Font
noto-fonts-cjk-sans
noto-fonts-cjk-serif

kitty

];
 }
