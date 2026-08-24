{
  config,
  lib,
  pkgs,
  ...
}:
{
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  wsl.enable = true;
  wsl.defaultUser = "primary";

  system.stateVersion = "26.05"; # Did you read the comment?
}
