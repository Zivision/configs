{
  config,
  lib,
  pkgs,
  ...
}:
{

  # Use Latest Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
