# ./modules/hyprland.nix
#
# Hyprland configuration

{ pkgs, lib, config, ... }: {

  options = {
    hyprland.enable = lib.mkEnableOption "enables hyprland";
  };

  config = lib.mkIf config.hyprland.enable {
    programs.kitty.enable = true;
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";
        bind = [
          "$mod, Q, exec, alacritty"
        ];
      };
    };
  };
}
