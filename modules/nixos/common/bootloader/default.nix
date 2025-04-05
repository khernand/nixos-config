{ config, pkgs, lib, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
