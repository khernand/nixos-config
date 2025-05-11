{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    my.system.services.x11.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable X11";
    };
  };

  config = lib.mkIf config.my.system.services.x11.enable {
    services.xserver = {
      enable = true;
      xkb.layout = "pl";
      xkb.variant = "";
      excludePackages = with pkgs; [xterm];
      displayManager.gdm.enable = true;
    };
  };
}
