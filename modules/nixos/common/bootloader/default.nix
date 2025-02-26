{ config, pkgs, lib, ... }:

# TODO: more boot settings? 
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
