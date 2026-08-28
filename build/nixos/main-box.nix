{
  config,
  lib,
  pkgs,
  ...
}:
{
  # If you get it, you get it.
  # El Psy Kongroo
  networking.hostName = "IBN-5100";
  
  # Use Latest Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
