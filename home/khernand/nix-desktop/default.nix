{nhModules, helpers, ...}: {
  imports = helpers.importAll "${nhModules}/services"
  ++ [
    "${nhModules}/common"
    "${nhModules}/desktop/hyprland"
  ];

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
}
