{ config, lib, pkgs, ... }:

{
  options = {
    ssh.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable SSH services";
    };
  }; 

  config = lib.mkIf config.ssh.enable {
    services.openssh = {
      enable = true;
      ports = [ 22 ];
      permitRootLogin = "no";
      passwordAuthentication = false;
      challengeResponseAuthentication = false;
    };
  };
}