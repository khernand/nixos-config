{
  lib,
  config,
  ...
}: {
  options = {
    my.system.programs.firefox.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Firefox";
    };
  };

  config = lib.mkIf config.my.system.programs.firefox.enable  {
    programs.firefox.enable = true;
  };
}
