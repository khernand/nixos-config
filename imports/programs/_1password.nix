{ config, lib, pkgs, ... }:

{
  options = {
    _1password.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable 1Password";
    };
  };

  config = lib.mkIf config._1password.enable {
    programs._1password.enable = true;
    programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = lib.attrNames config.users.users;
    };
  };
}