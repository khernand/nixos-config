{ config, lib, pkgs, ... }:

{
  options = {
    x11.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable 1Password";
    };
  };

  config = lib.mkIf config.x11.enable {
      services.xserver.enable = true;
      # Configure keymap in X11
      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };
  };
}