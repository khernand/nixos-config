{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    my.system.services.nvidia.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Nvidia graphics";
    };
  };

  config = lib.mkIf config.my.system.services.nvidia.enable  {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;

    hardware.nvidia = {
      open = false;
      powerManagement.enable = true;
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    environment.variables.VULKAN_ICD_PATH = "/etc/vulkan/icd.d";
    environment.variables.LAYER_PATH = "/etc/vulkan/implicit_layer.d";

    environment.systemPackages = with pkgs; [
      cudatoolkit
    ];
  };
}
