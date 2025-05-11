{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    my.system.programs.docker.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Docker";
    };
  };

  config = lib.mkIf config.my.system.programs.docker.enable {
    environment.systemPackages = with pkgs; [ distrobox ];

    virtualisation = {
      containers = {
        enable = true;
      };

      docker = {
        enable = true;

        daemon.settings.features.cdi = true;

        rootless = {
          enable = true;
          setSocketVariable = true;
          daemon.settings.features.cdi = true;
        };
      };

      oci-containers.backend = "docker";
    };

    # hardware.nvidia-container-toolkit.enable = config.nvidia.enable;
  };
}
