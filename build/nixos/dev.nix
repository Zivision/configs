{ config, lib, pkgs, ... }:

{
  home.username = "primary";
  home.homeDirectory = "/home/primary";
  home.stateVersion = "26.05";

programs.direnv = {
  enable = true;
  nix-direnv.enable = true;
};

programs.bash = {
    enable = true;
    initExtra = builtins.readFile ../home/.bashrc;

    sessionVariables = {
      EDITOR = "nvim";
    };
  };

home.packages = with pkgs; [

hunspell
hunspellDicts.en-us

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

  # Nix format
  nixfmt

  # Shell stuff
  shellcheck
  shfmt

# Neovim for quick edits
neovim

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
  yasnippet
  
  # Elfeed
  elfeed
  elfeed-org
  elfeed-tube
  elfeed-tube-mpv
  
  # Themes
  doom-themes
  
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
fzf
curl
wget
htop
findutils.locate
yt-dlp
vips
ffmpegthumbnailer
mediainfo
jq

tmux

# Fonts for emacs
nerd-fonts.symbols-only
nerd-fonts.iosevka

];
 }
