{
  description = "My system flake";

  inputs = {
    # NixOS official package source, using the nixos-26.05 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    # Nixos WSL Channel
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      legacyPkgs = nixpkgs.legacyPackages.${system};
    in
    {

      nixosConfigurations = {

        swiftx = nixpkgs.lib.nixosSystem {
          modules = [
            # Import the previous configuration.nix we used,
            # so the old configuration file still takes effect
            ./build/nixos/configuration.nix
            ./build/nixos/nvidia.nix
            ./build/nixos/swiftx.nix

            # Import home manager
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.primary = {
                imports = [

                  ./build/nixos/home.nix
                  ./build/nixos/dev.nix
                ];
              };
            }
          ];
        };

        nixbox = nixpkgs.lib.nixosSystem {
          modules = [
            # Import the previous configuration.nix we used,
            # so the old configuration file still takes effect
            ./build/nixos/configuration.nix
            ./build/nixos/nixbox.nix

            # Import home manager
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.primary = {
                imports = [

                  ./build/nixos/home.nix
                  ./build/nixos/dev.nix
                ];
              };
            }
          ];
        };
      };

      wsl = nixpkgs.lib.nixosSystem {
        modules = [
          # Import the previous configuration.nix we used,
          # so the old configuration file still takes effect
          ./build/nixos/wsl.nix

          # Import home manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.primary = {
              imports = [
                ./build/nixos/dev.nix
              ];
            };
          }
        ];
      };

      devShells.${system} = {

        default = legacyPkgs.mkShell {
          packages = with legacyPkgs; [
            pyright
            black
            python313Packages.pyflakes
            python313Packages.isort
          ];
          shellHook = ''
            echo "Dev Envrionment Ready!"
          '';
        };

        install = legacyPkgs.mkShell {
          packages = with legacyPkgs; [
            git
            emacs
            python3
          ];
          shellHook = ''
            echo "Ready to build new nix machine!"
          '';
        };

      };
    };
}
