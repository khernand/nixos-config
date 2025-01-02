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
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    # Enable Home Manager for khernand
    home-manager.users.khernand = { 
      home.stateVersion = "24.11"; # Set this to the latest Home Manager version or your desired version

      home.packages = with pkgs; [
        kate
        zsh
        git
        vscode
        discord
        nodejs # Required for Pure prompt
        obsidian
      ];

      programs.git = {
        enable = true;
        userName = "Kevin Hernandez";
        userEmail = "kphernand@gmail.com";

        extraConfig = {
          pull.rebase = "true";
          core.editor = "vim";
        };
      };

      home.sessionVariables = {
        EDITOR = "vim";
      };

      programs.neovim.enable = true;
    };

    # Define system-level user
    users.users.khernand = {
      isNormalUser = true;
      description = "kevin hernandez";
      extraGroups = [ "networkmanager" "wheel" "docker"];
      packages = with pkgs; [
        kate
      ];
      shell = pkgs.zsh;
    };
  };
}
