{ pkgs, ... }:

{
  # Call dbus-update-activation-environment on login
  services.xserver.updateDbusEnvironment = true;

  services.xserver.displayManager.gdm.enable = true;
  programs.uwsm.enable = true;

  # Enable Hyprland
  programs.hyprland = {
    withUWSM = true;
    enable = true;
  };

  # Enable security services
  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;
  security.pam.services = {
    hyprlock = {};
    gdm.enableGnomeKeyring = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    config.common.default = "*";
  };

  # Enable Ozone Wayland support in Chromium and Electron based applications
  environment.variables = {
    NIXOS_OZONE_WL = "1";
    DISABLE_QT5_COMPAT = "0";
    GDK_BACKEND = "wayland";
    ANKI_WAYLAND = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_QPA_PLATFORM = "wayland";
    DISABLE_QT_COMPAT = "0";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    MOZ_ENABLE_WAYLAND = "1";
    WLR_BACKEND = "wayland";
    WLR_RENDERER = "wayland";
    DL_VIDEODRIVER = "wayland";
    XCURSOR_SIZE = "24";
    HYPRLAND_HDR = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };

  environment.systemPackages = with pkgs; [
    file-roller # archive manager
    gnome-calculator
    gnome-pomodoro
    gnome-text-editor
    loupe # image viewer
    nautilus # file manager
    seahorse # keyring manager
    totem # Video player

    pavucontrol
    brightnessctl
    grim
    hypridle
    hyprlock
    hyprpaper
    hyprpicker
    libnotify
    networkmanagerapplet
    pamixer
    slurp
    wf-recorder
    wlr-randr
    wlsunset
  ];
}