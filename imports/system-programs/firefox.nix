{ config, lib, pkgs, ... }:

{
  options = {
    firefox.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Firefox";
    };
  };

  config = lib.mkIf config.firefox.enable {
    programs.firefox.enable = true;
  };
}