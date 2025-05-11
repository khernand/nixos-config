{
  lib,
  config,
  ...
}: {
  options = {
    my.system.services.ssh.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable SSH";
    };
  };

  config = lib.mkIf config.my.system.services.ssh.enable {
    services.openssh = {
      enable = true;
      ports = [ 22 ];
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        ChallengeResponseAuthentication = false;
      };
    };
  };
}
