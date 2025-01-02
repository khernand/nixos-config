{ config, lib, pkgs, ... }:

{
  options = {
    steam.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable 1Password";
    };
  };

  config = lib.mkIf config.steam.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;

      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}