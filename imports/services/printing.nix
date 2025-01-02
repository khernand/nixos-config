{ config, lib, pkgs, ... }:

{
  options = {
    printing.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable printing services";
    };
  };

  config = lib.mkIf config.printing.enable {
    # Enable CUPS to print documents.
    services.printing.enable = true;
  };
}