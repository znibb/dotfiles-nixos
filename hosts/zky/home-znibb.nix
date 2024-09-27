# home-znibb.nix
{ config, pkgs, user, ... }:

{
  # Let home manager install and manage itself
  programs.home-manager.enable = true;

  # Set Home Manager release
  home.stateVersion = "24.05";

  # User info
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";

  # User packages
  home.packages = with pkgs; [
    git
    alacritty
    zsh
    ranger
    #thefuck
  ];

  # Git
  programs.git = {
    enable = true;
    userName = "Pontus Berlin";
    userEmail = "pontus@b3rl1n.com";
    extraConfig = {
      push = { autoSetupRemote = true; };
      init.defaultBranch = "main";
      #commit.gpgsign = true;
      #gpg.format = "ssh";
      #user.signingkey = "~/.ssh/id_ed25519.pub";
    };
  };

  # Alacritty
  programs.alacritty = {
    enable = true;
  };

  # Zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ".."  = "cd ..";
      "nrs" = "sudo nixos-rebuild switch --flake ~/.dotfiles";
      "vim" = "nvim";
      "l"   = "ls -lah --group-directories-first";
    };

    oh-my-zsh = {
      enable = true;
      #plugins = [ "thefuck" ];
      theme = "robbyrussell";
    };
  };

  # NeoVim
  programs.neovim = {
    enable = true;
    extraConfig = ''
      set number relativenumber
      set tabstop shiftwidth=2 expandtab
    '';
  };
}
