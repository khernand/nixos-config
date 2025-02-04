{ pkgs, dotfiles, ... }:
{
  home.stateVersion = "24.11";

  # Install packages in the user’s profile
  home.packages = with pkgs; [
    kate
    zsh
    git
    vscode
    discord
    nodejs
    obsidian
    autojump
    kitty
    zsh-powerlevel10k
    fira-code
    fastfetch
  ];

  ## 🔹 Environment Variables for Hyprland
  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  fonts.fontconfig.enable = true;

  ## 🔹 Kitty Configuration
  home.file.".config/kitty/KittyTheme.conf".source = "${dotfiles}/KittyTheme.conf";

  programs.kitty = {
    enable = true;
    extraConfig = ''
      font_family Fira Code
      font_size 12
      include ${dotfiles}/KittyTheme.conf
    '';
  };

  ## 🔹 Git Configuration
  programs.git = {
    enable = true;
    userName = "Kevin Hernandez";
    userEmail = "2459865+khernand@users.noreply.github.com";
    extraConfig = {
      pull.rebase = "true";
      core.editor = "vim";
    };
  };

  ## 🔹 Zsh Configuration
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

    initExtra = ''
      [[ -f "$HOME/.local/share/autojump.sh" ]] && source "$HOME/.local/share/autojump.sh"
      [[ -f "$HOME/.common-aliases" ]]    && source "$HOME/.common-aliases"
      [[ -f "$HOME/.nix-aliases" ]] && source "$HOME/.nix-aliases"
    '';
  };

  # 🔹 Symlink dotfiles from the dotfile repo
  home.file.".common-aliases".source = "${dotfiles}/.common-aliases";
  home.file.".nix-aliases".source = "${dotfiles}/nixos/.nix-aliases";
  home.file.".local/share/autojump.sh".source = "${pkgs.autojump}/etc/profile.d/autojump.sh";
  # Symlinks for hyprland config files
  home.file.".config/waybar/config".source = "${dotfiles}/nixos/hyprland/modules/waybar/config";
  home.file.".config/waybar/style.css".source = "${dotfiles}/waybar/style.css";

  programs.neovim.enable = true;
}
