{
  config,
  lib,
  pkgs,
  ...
}: 
{
  options = {
    profiles.khernand.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable khernand user profile";
    };
  };

  config = lib.mkIf config.profiles.khernand.enable {
    users.users.khernand = {
      isNormalUser = true;
      description = "kevin hernandez";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
        pkgs.kate
      ];
    };
  };
}
