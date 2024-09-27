# default.nix
{ pkgs, lib, ... }: {
  
  imports = [
    ./hyprland.nix
  ];

  hyprland.enable = lib.mkDefault false;
}
