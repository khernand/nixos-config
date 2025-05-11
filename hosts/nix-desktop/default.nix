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

  # Enable system level programs
  my.system.programs._1password.enable = true;
  my.system.programs.docker.enable = true;
  my.system.programs.firefox.enable = true;
  my.system.programs.steam.enable = true;
  
  # Define hostname
  networking.hostName = hostname;

  # Set the global NixOS state version
  system.stateVersion = "24.11";
}
