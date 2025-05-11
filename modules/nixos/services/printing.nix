{
  lib,
  config,
  ...
}: {
  options = {
    my.system.services.printing.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable printing";
    };
  };

  config = lib.mkIf config.my.system.services.printing.enable {
    # Enable CUPS to print documents.
    services.printing.enable = true;
  };
}
