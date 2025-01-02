{ config, lib, pkgs, ... }:

{
  options = {
    zsh.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable zsh and plugins";
    };
  };

  config = lib.mkIf config.zsh.enable {
    ## Install antigen
    environment.systemPackages = with pkgs; [
      antigen
    ];
    environment.etc."zsh/antigen.zsh".source = "${pkgs.antigen}/share/antigen/antigen.zsh";

    ## Configure ZSH
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;

      ohMyZsh = {
        enable = true;
        plugins = ["sudo" "git" "gitignore" "web-search" "z" "1password" "docker"];
        theme = "robbyrussell";
      };
    };
  };
}