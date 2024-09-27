# ./flake.nix
#
# Sets up repos and flames for Nix, Home-Manager etc
#
# Loads ./hosts/default.nix next

{
  description = "NixOS system configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self,
              nixpkgs,
              nixpkgs-stable,
              nixos-hardware,
              home-manager,
              nixvim, }@inputs: {
    nixosConfigurations = (
      import ./hosts {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs nixpkgs-stable nixos-hardware home-manager nixvim;
      }
    );
  };
}
