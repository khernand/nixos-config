{ config, lib, pkgs, ... }:

{
  options = {
    vscode.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable VSCode";
    };
  };

  config = lib.mkIf config.vscode.enable {
    environment.systemPackages = with pkgs; [
      vscode
    ];
  };
}