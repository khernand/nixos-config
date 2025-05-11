{
  pkgs,
  dotfiles, 
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 100000;
    };

    oh-my-zsh = {
      enable = true;
      plugins = ["sudo" "git" "docker"];
    };

    plugins = [
      {
        name = "powerlevel10k-config";
        src = "${dotfiles}";
        file = "p10k-pure.zsh";
      }
      {
        name = "zsh-powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
        file = "powerlevel10k.zsh-theme";
      }
    ];

    initContent = ''
      [[ -f "$HOME/.local/share/autojump.sh" ]] && source "$HOME/.local/share/autojump.sh"
      [[ -f "$HOME/.common-aliases" ]]    && source "$HOME/.common-aliases"
      [[ -f "$HOME/.nix-aliases" ]] && source "$HOME/.nix-aliases"
    '';
  };
}
