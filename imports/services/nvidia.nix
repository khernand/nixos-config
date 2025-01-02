{ config, lib, pkgs, ... }:

{
  options = {
    nvidia.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable NVIDIA GPU";
    };
  };

  config = lib.mkIf config.nvidia.enable {
    # NVIDIA GPU settings
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.graphics.enable = true;

    hardware.nvidia = {
      open = true;
      modesetting.enable = true;
      # Uncomment the following for PRIME offloading support
      #prime = {
      #   offload.enable = true;
      #};
    };

    hardware.graphics.enable32Bit = true;
    environment.variables.VULKAN_ICD_PATH = "/etc/vulkan/icd.d";
    environment.variables.LAYER_PATH = "/etc/vulkan/implicit_layer.d";
  };
}