{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    my.system.services.bluetooth.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Bluetooth";
    };
  };

  config = lib.mkIf config.my.system.services.bluetooth.enable  {
      hardware.bluetooth.enable = true;
      hardware.bluetooth.powerOnBoot = true;
      hardware.bluetooth.settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
          Privacy = "device";
          JustWorksRepairing = "always";
          Class = "0x000100";
          FastConnectable = true;
        };
      };

      services.blueman.enable = true;
  
      hardware.xpadneo.enable = true; # Driver for Xbox Controller

      boot = {
        extraModulePackages = with config.boot.kernelPackages; [ xpadneo ];
        extraModprobeConfig = ''
          options bluetooth disable_ertm=Y
        '';
        # connect Xbox controller
      };
      
      systemd.user.services.mpris-proxy = {
        description = "Mpris proxy";
        after = [ "network.target" "sound.target" ];
        wantedBy = [ "default.target" ];
        serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
      };
  };
}
