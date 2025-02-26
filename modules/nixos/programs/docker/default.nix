{
  pkgs,
  ...
}: {
    # hardware.nvidia-container-toolkit.enable = config.nvidia.enable;
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
}
