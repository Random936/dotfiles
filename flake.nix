{
  description = "Configuration flake for RandomCTF";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations.randomctf = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [ ./nixos/configuration.nix ];
      };

      homeConfigurations.random = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [
          ./home-manager/home.nix
        ];
      };
    };
}
