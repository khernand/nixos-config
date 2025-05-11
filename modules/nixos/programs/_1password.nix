{
  lib,
  config,
  ...
}: {
  options = {
    my.system.programs._1password.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable 1 Password";
    };
  };


  config = lib.mkIf config.my.system.programs._1password.enable {
    programs._1password.enable = true;
    programs._1password-gui = {
      enable = true;
      polkitPolicyOwners = lib.attrNames config.users.users;
    };
  };
}
