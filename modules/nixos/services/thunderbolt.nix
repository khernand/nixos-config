{
  lib,
  config,
  ...
}: {
  options = {
    my.system.services.thunderbolt.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Thunderbolt";
    };
  };

  config = lib.mkIf config.my.system.services.thunderbolt.enable {
    services.hardware.bolt.enable = true;
  };
}
