{
  config,
  lib,
  pkgs,
  ...
}:
{
  networking.hostName = "NixBox"; # Define your hostname.

  # Use Latest Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
