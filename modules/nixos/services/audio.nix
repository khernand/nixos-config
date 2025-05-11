{
  lib,
  config,
  ...
}: {
  options = {
    my.system.services.audio.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Audio";
    };
  };

  config = lib.mkIf config.my.system.services.audio.enable  {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
