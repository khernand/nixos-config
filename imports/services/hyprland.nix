{ config, lib, pkgs, ... }:

{
  options = {
    hyprland.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable Hyprland as a Wayland window manager.";
    };
  };

  config = lib.mkIf config.hyprland.enable {
    # Enable Hyprland
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    # Enable X server for SDDM to work
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;

    # Enable XDG Desktop Portal for compatibility with apps
    xdg.portal = {
      enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };

    # Set up essential environment variables for Wayland
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      WLR_NO_HARDWARE_CURSORS = "1";
    };


    # Install essential system-wide packages
    environment.systemPackages = with pkgs; [
      hyprland
      waybar
      wl-clipboard
    ];
  };
}
