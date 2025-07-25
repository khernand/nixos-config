{ 
  hostname,
  nixosModules,
  helpers,
  ... 
}: {

  imports = [
    ./hardware-configuration.nix
  ]
  # System desktop environments
  ++ helpers.importAll "${nixosModules}/desktop"
  # Common configurations and system level programs/services
  ++ helpers.importAll "${nixosModules}/common"
  # Custom System level services
  ++ helpers.importAll "${nixosModules}/services"
  # Custom System level programs
  ++ helpers.importAll "${nixosModules}/programs";

  # Enable system desktop environment
  my.system.desktop.hyprland.enable = true;

  # Enable system services
  my.system.services.audio.enable = true;
  my.system.services.bluetooth.enable = true;
  my.system.services.networking.enable = true;
  my.system.services.thunderbolt.enable = true;
  my.system.services.nvidia.enable = true;
  my.system.services.ssh.enable = true;
  my.system.services.x11.enable = true;
  my.system.services.printing.enable = true;
  my.system.services.sunshine.enable = true;

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
