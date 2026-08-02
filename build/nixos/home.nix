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
  Enabled=false
'';

};

programs.thunderbird.enable = true;

services.nextcloud-client = {
  enable = true;
  startInBackground = true;
};

programs.bash = {
    enable = true;
    initExtra = builtins.readFile ../home/.bashrc;

    sessionVariables = {
      EDITOR = "nvim";
    };
  };

home.packages = with pkgs; [

libreoffice-qt6-fresh
hunspell
hunspellDicts.en-us

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
brave
firefox

kdePackages.kdenlive

audacity

# For Emacs
  python3
  gcc
  gnumake
  ripgrep
  fd
  cmake
  libtool
  ispell
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

  # Backup Editor
  vscode

# emacs itself
((emacsPackagesFor emacs-pgtk).emacsWithPackages (epkgs: with epkgs; [
  evil
  evil-collection
  general
  which-key
  doom-modeline
  vertico
  consult
  orderless
  nerd-icons-dired
  nerd-icons-completion
  golden-ratio
  corfu
  cape
  apheleia
  beacon
  vertico-posframe
  marginalia
  embark
  embark-consult
  undo-fu
  dashboard
  envrc

  # Emacs Utilities
  magit
  emms
  vterm
  mu4e
  yasnippet
  
  # Elfeed
  elfeed
  elfeed-org
  elfeed-tube
  elfeed-tube-mpv
  
  # Themes
  doom-themes
  jazz-theme
  badwolf-theme
  
  # Eshell
  eshell-syntax-highlighting
  eshell-prompt-extras

  # Org mode
  olivetti
  org-modern
  org-appear
  toc-org
  org-roam
  jinx

  ## Languages
  # Clojure
  clojure-mode
  cider
  paredit
  
  # Python
  lsp-pyright
  pet
  pyvenv

  # Nix
  nix-mode

  # Yaml
  yaml-mode
]))

fastfetch
  git
  curl
  wget
  htop
  fzf
  findutils.locate
  yt-dlp
  vips
  ffmpegthumbnailer
  mediainfo
  jq

# Fonts for emacs
nerd-fonts.symbols-only
nerd-fonts.iosevka

# Chinese Font
noto-fonts-cjk-sans
noto-fonts-cjk-serif

kitty

];
 }
