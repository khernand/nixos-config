# This is the the implementation of imports/services/plasma.nix. It can be used as an example of the syntax for defining services and system-programs

```
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
```
