{
  description = "My system flake";

inputs = {
  # NixOS official package source, using the nixos-25.11 branch here
  nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  # Home manager
  home-manager = {
    url = "github:nix-community/home-manager/release-25.11";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};

outputs = { self, nixpkgs, home-manager, ... }@inputs: {
  nixosConfigurations = {
    swiftx = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix
        ./nvidia.nix
        ./swiftx.nix

        # Import home manager
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.primary = import ./home.nix;
        }
      ];
    };
    nixbox = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix
        ./nixbox.nix

        # Import home manager
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.primary = import ./home.nix;
        }
      ];
    };
  };
};
}
