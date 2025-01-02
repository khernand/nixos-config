{ config, lib, pkgs, ... }:

{
  options = {
    plasma.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Plasma as desktop manager";
    };
  };

  config = lib.mkIf config.plasma.enable {
    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
  };
}