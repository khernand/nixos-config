{
  userConfig,
  pkgs,
  dotfiles,
  helpers,
  dotfilesDir,
  ...
}: {
  imports = helpers.importAll ../programs;

  # Home-Manager configuration for the user's home environment
  home = {
    username = "${userConfig.name}";
    homeDirectory =
      if pkgs.stdenv.isDarwin
      then "/Users/${userConfig.name}"
      else "/home/${userConfig.name}";
  };

  home.packages = with pkgs; [
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
    ffmpeg
    pipenv
    python3
    python3Packages.virtualenv
    prusa-slicer
    gdb
    flashrom
    hexedit
    hdf5
    ghex
    file
    clipse
    tmux
    btop
    gnome-terminal
    code-cursor
  ];

  ## Environment Variables for Hyprland
  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  # Symlink dotfiles from the dotfile repo
  home.file.".common-aliases".source = "${dotfiles}/.common-aliases";
  home.file.".nix-aliases".source = "${dotfiles}/nixos/.nix-aliases";
  home.file.".aliases".source = "${dotfilesDir}/aliases/.aliases";
  home.file.".local/share/autojump.sh".source = "${pkgs.autojump}/etc/profile.d/autojump.sh";

  programs.neovim.enable = true;

  # Catpuccin flavor and accent
  catppuccin = {
    flavor = "macchiato";
    accent = "lavender";
  };
}
