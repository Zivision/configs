{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    # Include Modules
    <nixos-wsl/modules>
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  wsl.enable = true;
  wsl.defaultUser = "primary";

  system.stateVersion = "26.05"; # Did you read the comment?
}
