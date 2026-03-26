{
  config,
  lib,
  pkgs,
  ...
}:
# This is for the swift x
{
  # Enable Prime
  hardware.nvidia.prime = {
    sync.enable = true;

    # Make sure to use the correct Bus ID values for your system!
    #intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:04:0:0";
    amdgpuBusId = "PCI:01:0:0";
  };

  # Network Fixes
  networking.networkmanager.wifi.powersave = false;

  boot.extraModprobeConfig = ''
    options mt7921e disable_aspm=1
  '';

}
