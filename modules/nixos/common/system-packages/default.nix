{ config, pkgs, lib, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    gcc
    glib
    gnumake
    killall
    kdePackages.kate
    nixfmt-rfc-style
    nixd
  ];
}
