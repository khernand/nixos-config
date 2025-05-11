{ 
  hostname,
  nixosModules,
  helpers,
  ... 
}: {

  imports = [
    ./hardware-configuration.nix
    "${nixosModules}/common"
    # Desktop environment
    # "${nixosModules}/desktop/sway"
    "${nixosModules}/desktop/hyprland"
    # System level services
    "${nixosModules}/services/nvidia"
    "${nixosModules}/services/bluetooth"
    "${nixosModules}/services/audio"
    "${nixosModules}/services/printing"
    "${nixosModules}/services/networking"
    "${nixosModules}/services/thunderbolt"
    "${nixosModules}/services/ssh"
    "${nixosModules}/services/x11"
  ]
  # System level programs
  ++ helpers.importAll "${nixosModules}/programs";
  
  # Define hostname
  networking.hostName = hostname;

  # Set the global NixOS state version
  system.stateVersion = "24.11";
}
