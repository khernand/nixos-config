{ config, lib, pkgs, ... }:

{
  options = {
    thunderbolt.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable thunderbolt";
    };
  };

  config = lib.mkIf config.thunderbolt.enable {
    services.hardware.bolt.enable = true;
  };
}
