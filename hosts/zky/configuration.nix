# ./hosts/zky/configuration.nix
{ pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules
  ];

  hyprland.enable = true;

  # Boot settings
  boot = {
    # Use the latest linux kernel
    kernelPackages = pkgs.linuxPackages_latest;
    # Grub bootloader stuff
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        # How many past configurations to keep
        configurationLimit = 10;
      };
      timeout = 3;
    };
  };

  # Networking
  networking = {
    hostName = "zky";
    networkmanager = {
      enable = true;
    };
  };

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable the OpenSSH daemon
  services.openssh.enable = true;

  # Host-specific packages
  environment.systemPackages = with pkgs; [
    dolphin
    gnupg
    gpg-tui
    firefox
    wofi
    home-manager
    sddm
  ];

  # Display manager
  services.displayManager = {
    defaultSession = "hyprland";
    sddm = {
      enable = true;
      wayland.enable = true;
    };
  };

  # Gnupg compatibility
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  
  # =========
  # HANDS OFF
  system.stateVersion = "24.05";
}
