{
  lib,
  config,
  ...
}: {
  options = {
    my.system.services.plasma.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Plasma desktop manager requirements";
    };
  };

  config = lib.mkIf config.my.system.services.plasma.enable {
    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
  };
}
