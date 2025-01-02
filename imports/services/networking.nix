{ config, lib, pkgs, ... }:

{
  options = {
    networking.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable networking services";
    };
  };

  config = lib.mkIf config.networking.enable {
    networking.networkmanager.enable = true;
  };
}