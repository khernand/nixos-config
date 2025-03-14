{ pkgs, ... }:

{
  # Call dbus-update-activation-environment on login
  services.xserver.updateDbusEnvironment = true;

  # Enable sway
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # Enable security services
  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;
  security.pam.services = {
    swaylock = {};
    gdm.enableGnomeKeyring = true;
  };

  # Enable Ozone Wayland support in Chromium and Electron based applications
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    XCURSOR_SIZE = "24";
  };

  environment.systemPackages = with pkgs; [
    grim
    slurp
    wl-clipboard
    mako
  ];
}