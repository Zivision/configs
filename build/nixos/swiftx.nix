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
  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;

  environment.variables = {
  LIBVA_DRIVER_NAME = "nvidia";
  GBM_BACKEND = "nvidia-drm";
  __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  NVD_BACKEND = "direct";
  # For Wayland
  EGL_PLATFORM = "wayland";
  NIXOS_OZONE_WL = "1";
};

}
