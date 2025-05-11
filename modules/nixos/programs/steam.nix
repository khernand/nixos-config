{
  lib,
  config,
  ...
}: {
  options = {
    my.system.programs.steam.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Steam";
    };
  };

  config = lib.mkIf config.my.system.programs.steam.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;

      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}
