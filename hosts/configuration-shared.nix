# ./hosts/configuration-shared.nix
#
# Shared configuration

{ lib, config, pkgs, stable, inputs, user, ... }:

let
  terminal = "alacritty";
  editor = "nvim";

  language_default = "en_GB.UTF-8";
  language_local = "sv_SE.UTF-8";
in {
  # Default user
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  # Nix settings
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  # Localization
  time.timeZone = "Europe/Stockholm";
  i18n = {
    defaultLocale = "${language_default}";
    extraLocaleSettings = {
      LC_TIME = "${language_local}";
      LC_MONETARY = "${language_local}";
    };
  };

  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [
    neovim
    ripgrep # used by nvim
    xclip   # clipboard tool for nvim
    alacritty
    git
    lazygit
    wget
    tree
    tlrc # man alternative 'tldr' written in rust
  ];

}
