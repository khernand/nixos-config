{ config, pkgs, home-manager, dotfiles, ... }:

{
  imports = [
    # Standard hardware + Home Manager modules
    ./hardware-configuration.nix
    home-manager.nixosModules.home-manager
  ];

  # Limit build resources
  nix.settings.max-jobs = 15;

  # Enable system services, etc.
  nvidia.enable = true;
  bluetooth.enable = true;
  audio.enable = true;
  printing.enable = true;
  x11.enable = true;
  networking.enable = true;
  plasma.enable = true;
  thunderbolt.enable = true;

  # Enable system programs
  _1password.enable = true;
  steam.enable = true;
  firefox.enable = true;
  docker.enable = true;

  # Define hostname
  networking.hostName = "nixos";

  # Enable Zsh and define system-level user
  programs.zsh.enable = true;
  
  users.users.khernand = {
    isNormalUser = true;
    description = "Kevin Hernandez";
    group = "khernand";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [ kate ];
    shell = pkgs.zsh;
  };

  # Create the system level khernand group
  users.groups.khernand = {};

  # ===========================
  # Home Manager configuration
  # ===========================
  home-manager.users.khernand = import ../../profiles/khernand.nix {
    inherit pkgs dotfiles;
  };

  # Set the global NixOS state version
  system.stateVersion = "24.11";
}
