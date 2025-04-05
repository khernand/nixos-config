{ 
  inputs,
  outputs,
  lib,
  config,
  userConfig,
  pkgs,
  ...
}: {
  # Nix settings
  nix.settings = {
    experimental-features =  ["nix-command" "flakes" ];
    auto-optimise-store = true;
    substituters = [
      "https://hyprland.cachix.org" 
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    max-jobs = 15;
  };

  nix.gc = {
    automatic = true;
    randomizedDelaySec = "14m";
    options = "--delete-older-than 10d"
  };

  # Enable Zsh and define system-level user
  programs.zsh.enable = true;
  
  users.users.${userConfig.name} = {
    isNormalUser = true;
    initialPassword = "password";
    description = userConfig.fullName;
    extraGroups = [ "networkmanager" "wheel" "docker" "video"];
    shell = pkgs.zsh;
  };

  # Nixpkgs configuration
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # Register flake inputs for nix commands
  nix.registry = lib.mapAttrs (_: flake: {inherit flake;}) (lib.filterAttrs (_: lib.isType "flake") inputs);

  # Add inputs to legacy channels
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs' (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;
}
