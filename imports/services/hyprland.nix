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
    programs.hyprland.enable = true;

    # Enable XWayland for compatibility
    services.xserver.enable = true;
    services.xserver.displayManager.sddm.enable = true;

    # Set up essential environment variables for Wayland
    environment.sessionVariables = {
      XDG_SESSION_TYPE = "wayland";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      WLR_NO_HARDWARE_CURSORS = "1";
    };

    # Install essential system-wide packages
    environment.systemPackages = with pkgs; [
      hyprland
      waybar
      wofi
      swaync
      hyprlock
      pywal
      pywalfox
      rofi-wayland
      dunst
      mako
      alacritty
      swaylock
      swayidle
      wl-clipboard
      grim
      slurp
    ];
  };
}
