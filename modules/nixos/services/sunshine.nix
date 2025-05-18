{
  lib,
  config,
  ...
}: {
  options = {
    my.system.services.sunshine.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Sunshine game streaming";
    };
  };

  config = lib.mkIf config.my.system.services.sunshine.enable {
    services.sunshine = {
        enable = true;
        autoStart = true;
        capSysAdmin = true;
        openFirewall = true;
    };
  };
}
 
