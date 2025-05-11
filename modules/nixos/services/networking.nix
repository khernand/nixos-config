{
  lib,
  config,
  ...
}: {
  options = {
    my.system.services.networking.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Networking";
    };
  };

  config = lib.mkIf config.my.system.services.networking.enable  {
    networking.networkmanager.enable = true;
  };
}
