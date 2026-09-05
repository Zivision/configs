{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

# Bootloader.
boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;

virtualisation.virtualbox.host.enable = true;
users.extraGroups.vboxusers.members = [ "primary" ];

# App armor
security.apparmor.enable = true;

nix.package = pkgs.nixVersions.latest;

# Steam
programs.steam.enable = true;

# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Configure network proxy if necessary
# networking.proxy.default = "http://user:password@proxy:port/";
# networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable networking
networking.networkmanager.enable = true;

# Set your time zone.
time.timeZone = "America/Chicago";

# Select internationalisation properties.

i18n = {
  defaultLocale = "en_US.UTF-8";

  extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "zh_CN.UTF-8/UTF-8"
  ];

  inputMethod = {
    # Available since NixOS 24.11
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      ignoreUserConfig = true;    # Use settings below, ignore user config
      addons = with pkgs; [
        fcitx5-chewing    # Chewing (Traditional Chinese)
        qt6Packages.fcitx5-chinese-addons
        fcitx5-mozc       # Japanese input method
      ];
      settings = {
        inputMethod = {
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "keyboard-us";
          };
          "Groups/0/Items/0".Name = "keyboard-us";
          "Groups/0/Items/1".Name = "chewing";
          "Groups/0/Items/2".Name = "mozc";
        };
      };
    };
  };
};


nixpkgs.config.allowUnfree = true;

# Firewall
networking.firewall = {
  enable = true;
  #allowedTCPPorts = [  ];
  #allowedUDPPorts = [  ];
};

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
system.stateVersion = "25.05"; # Did you read the comment?

programs.gnupg.agent = {
  enable = true;
  pinentryPackage = pkgs.pinentry-qt;
};

environment.sessionVariables.NIXOS_OZONE_WL = "1";

programs.sway = {
  enable = true;
  wrapperFeatures.gtk = true;
};

security.polkit.enable = true;

# Enable flakes
nix.settings.experimental-features = [ "nix-command" "flakes" ];

# Enable the X11 windowing system.
# You can disable this if you're only using the Wayland session.
services.xserver.enable = true;

# Enable the KDE Plasma Desktop Environment.
services.displayManager.sddm.enable = true;
services.desktopManager.plasma6.enable = true;

# Configure keymap in X11
services.xserver.xkb = {
  layout = "us";
  variant = "";
};

# Enable CUPS to print documents.
#services.printing.enable = true;

# Set editor to neovim for quick edits
environment.variables.EDITOR = "nvim";

# Enable sound with pipewire.
services.pulseaudio.enable = false;
security.rtkit.enable = true;
services.pipewire = {
  enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
  pulse.enable = true;
  # If you want to use JACK applications, uncomment this
  #jack.enable = true;

  # use the example session manager (no others are packaged yet so this is enabled by default,
  # no need to redefine it in your config for now)
  #media-session.enable = true;
};

# Define a user account. Don't forget to set a password with ‘passwd’.
users.users.primary = {
  isNormalUser = true;
  description = "Primary";
  extraGroups = [ "networkmanager" "wheel" "docker" ];
};

services.clamav.daemon.enable = true;

services.clamav.updater.enable = true;

services.flatpak.enable = true;

environment.systemPackages = with pkgs; [

swaylock

flatpak
 clamav
gparted

];
}
