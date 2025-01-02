{ config, lib, pkgs, ... }:

{
  options = {
    bluetooth.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Bluetooth";
    };
  };

  config = lib.mkIf config.bluetooth.enable {
    # Bluetooth
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    hardware.bluetooth.settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
    services.blueman.enable = true;

    systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = [ "network.target" "sound.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
    };
  };
}