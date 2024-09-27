# ./hosts/default.nix
#
# Loads shared and host-specific configurations

{ lib, inputs, nixpkgs, nixpkgs-stable, nixos-hardware, home-manager, nixvim, ... }:

let
  system = "x86_64-linux";
  user = "znibb"; # Default user

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  stable = import nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };

  lib = nixpkgs.lib;
in {
  zky = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs system stable user; };
    modules = [
      # Shared config
      ./configuration-shared.nix
      # Host-specific config
      ./zky/configuration.nix
      
      # Neovim
      nixvim.nixosModules.nixvim

      # Home-manager
      home-manager.nixosModules.home-manager {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit user; };
          users.${user} = import ./zky/home-${user}.nix;
        };
      }
    ];
  };
}
