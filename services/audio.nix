{ config, lib, pkgs, ... }:

{
  options = {
    audio.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable sound related services";
    };
  };

  config = lib.mkIf config.audio.enable {
    # Enable sound with pipewire.
    services.pulseaudio.enable = false;

    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}