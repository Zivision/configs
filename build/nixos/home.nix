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
hunspellDicts.uk_UA
hunspellDicts.th_TH

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

# emacs itself
((emacsPackagesFor emacs-pgtk).emacsWithPackages (epkgs: [
  epkgs.mu4e
  epkgs.evil
  epkgs.evil-collection
  epkgs.general
  epkgs.which-key
  epkgs.doom-modeline
  epkgs.vertico
  epkgs.consult
  epkgs.orderless
  epkgs.magit
  epkgs.emms
  epkgs.elfeed
  epkgs.elfeed-org
  epkgs.elfeed-tube
  epkgs.elfeed-tube-mpv
  epkgs.nerd-icons-dired
  epkgs.nerd-icons-completion
  epkgs.golden-ratio
  epkgs.vterm
  epkgs.corfu
  epkgs.cape
  epkgs.apheleia
  epkgs.beacon
  epkgs.yasnippet
  epkgs.vertico-posframe
  epkgs.marginalia
  epkgs.embark
  epkgs.embark-consult
  epkgs.undo-fu
  epkgs.dashboard

  # Themes
  epkgs.doom-themes
  epkgs.jazz-theme
  epkgs.badwolf-theme
  
  # Eshell
  epkgs.eshell-syntax-highlighting
  epkgs.eshell-prompt-extras

  # Org mode
  epkgs.olivetti
  epkgs.org-modern
  epkgs.org-appear
  epkgs.toc-org
  epkgs.org-roam

  ## Languages
  # Python
  epkgs.lsp-pyright
  epkgs.pet
  epkgs.pyvenv

  # Nix
  epkgs.nix-mode
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
