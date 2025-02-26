{ 
  nixosModules,
  ... 
}: {
  imports = [
    "${nixosModules}/common/bootloader"
    "${nixosModules}/common/languages"
    "${nixosModules}/common/nix-settings"
    "${nixosModules}/common/system-packages"
    "${nixosModules}/common/fonts"
  ];
}
