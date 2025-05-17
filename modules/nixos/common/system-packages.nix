{  pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    gcc
    glib
    gnumake
    unzip
    killall
    kdePackages.kate
    nixfmt-rfc-style
    nixd
    btop
    #lazyvim deps
    neovim
    fzf
    lazygit
    ripgrep
    fd
  ];
}
