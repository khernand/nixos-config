# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Limit build resources since it was leading to 100% CPU usage on my machine
  nix.settings.max-jobs = 15;

  # Enable services
  nvidia.enable = true;
  bluetooth.enable = true;
  audio.enable = true;
  printing.enable = true;
  x11.enable = true;
  networking.enable = true;
  plasma.enable = true;

  # Enable system programs
  _1password.enable = true;
  steam.enable = true;
  firefox.enable = true;
  zsh.enable = true;
  docker.enable = true;

  # Define hostname
  networking.hostName = "nixos";

  # Enable user profiles.
  profiles.khernand.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
