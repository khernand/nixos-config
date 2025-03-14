{ 
  inputs,
  hostname,
  nixosModules,
  userConfig,
  pkgs,
  ... 
}: {
  imports = [
    ./hardware-configuration.nix
    "${nixosModules}/common"
    # Desktop environment
    # "${nixosModules}/desktop/sway"
    "${nixosModules}/desktop/hyprland"
    # System level programs
    "${nixosModules}/programs/steam"
    "${nixosModules}/programs/_1password"
    "${nixosModules}/programs/docker"
    "${nixosModules}/programs/firefox"
    # System level services
    "${nixosModules}/services/nvidia"
    "${nixosModules}/services/bluetooth"
    "${nixosModules}/services/audio"
    "${nixosModules}/services/printing"
    "${nixosModules}/services/networking"
    "${nixosModules}/services/thunderbolt"
    "${nixosModules}/services/ssh"
    "${nixosModules}/services/x11"
  ];
  
  # Define hostname
  networking.hostName = hostname;

  # Set the global NixOS state version
  system.stateVersion = "24.11";
}
