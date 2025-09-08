{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    my.system.desktop.plasma.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable KDE Plasma desktop environment";
    };
  };

  config = lib.mkIf config.my.system.desktop.plasma.enable {
    # Enable the Plasma 6 desktop environment.
    services.desktopManager.plasma6.enable = true;

    # SDDM is the native display manager for Plasma.
    services.displayManager.sddm.enable = true;

    # Enable core security and session services.
    security.polkit.enable = true;

    # The Plasma module automatically configures the correct XDG portal.
    xdg.portal.enable = true;

    # Wayland and NVIDIA hardware acceleration variables.
    # Plasma's session handles most desktop-specific variables automatically.
    environment.variables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      # The following are for NVIDIA GPUs. Remove if you don't have one.
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    };

    # Install KDE equivalent applications and still-useful utilities.
    environment.systemPackages = with pkgs; [
      # General utilities that are still useful
      wl-clipboard
      pavucontrol
      brightnessctl
      libnotify
      pamixer
    ];
  };
}