{
  description = "Configuration flake for RandomCTF";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... } @ inputs: {
    nixosConfigurations.randomctf = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./config/shared.nix
        ./config/omen.nix
      ];
    };

    homeConfigurations.random = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        extraSpecialArgs.user = "random";
        modules = [
          ./home/headful-nixos.nix
        ];
    };

    nixosConfigurations."r330-media" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./config/media.nix
      ];
    };

    homeConfigurations.sampledb = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      extraSpecialArgs.user = "sampledb";
      modules = [
        ./home/headless-nixos.nix
      ];
    };

    nixosConfigurations."sampledb-dev" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./config/sampledb.nix
      ];
    };

    homeConfigurations.media = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."x86_64-linux";
      extraSpecialArgs.user = "media";
      modules = [
        ./home/headless-nixos.nix
      ];
    };

    darwinConfigurations."Jadens-MacBook-Air" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = { inherit inputs; };
      modules = [
        ./config/darwin.nix
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jadenmaxwell = import ./home/darwin.nix;
        }
      ];
    };

    homeConfigurations.jadenmaxwell = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."aarch64-darwin";
      modules = [
        ./home/darwin.nix
      ];
    };
  };
}
