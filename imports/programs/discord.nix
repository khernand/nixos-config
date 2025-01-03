{ config, lib, pkgs, ... }:

{
  options = {
    discord.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Discord";
    };
  };

  config = lib.mkIf config.discord.enable {
    environment.systemPackages = with pkgs; [
      discord
    ];
  };
}