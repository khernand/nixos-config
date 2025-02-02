# This is the current implementation of configuration.nix file that lives in hosts/desktop

```nix

{ config, pkgs, home-manager, dotfiles, userName, userDescription, networkingHostName, ... }:

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
  networking.hostName = networkingHostName;

  # Enable Zsh and define system-level user
  programs.zsh.enable = true;
  
  users.users.${userName} = {
    isNormalUser = true;
    description = userDescription;
    group = userName;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [ kate ];
    shell = pkgs.zsh;
  };

  # Create the system level user group
  users.groups.${userName} = {};

  # ===========================
  # Home Manager configuration
  # ===========================
  home-manager.users.${userName} = import ../../profiles/${userName}.nix {
    inherit pkgs dotfiles;
  };

  # Set the global NixOS state version
  system.stateVersion = "24.11";
}

```
