{
  description = "Entrypoint flake for NixOS configurations";

  inputs = {
    # Nixpkgs
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS profiles to optimize settings for different hardware
    hardware.url = "github:nixos/nixos-hardware";

    # Personal Dotfiles repository
    dotfiles.url = "github:khernand/dotfiles";

    # Global catppuccin theme
    catppuccin.url = "github:catppuccin/nix";

    # Nix Darwin (for MacOS machines)
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Homebrew
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs =
  {
    self,
    catppuccin,
    darwin,
    home-manager,
    nix-homebrew,
    nixpkgs,
    dotfiles,
    ...
  }@ inputs: let
      inherit (self) outputs;

      # Create one single, patched package set for the entire system.
      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };

      # Load helpers globally
      helpers = import ./helpers { lib = nixpkgs.lib; };

      # Define user configurations
      users = {
        khernand = {
          avatar = ./files/avatar/face;
          email = "2459865+khernand@users.noreply.github.com";
          fullName = "Kevin Hernandez";
          name = "khernand";
        };
      };

      # Function for NixOS system configuration
      mkNixosConfiguration = hostname: username:
        nixpkgs.lib.nixosSystem {
          # Explicitly pass our patched pkgs set to the system.
          pkgs = pkgs;
          specialArgs = {
            inherit inputs outputs hostname helpers;
            userConfig = users.${username};
            nixosModules = "${self}/modules/nixos";
            dotfilesDir = "${self}/dotfiles";
          };
          modules = [
            ./hosts/${hostname}
          ];
        };

      # Function for Home Manager configuration
      mkHomeConfiguration = system: username: hostname:
        home-manager.lib.homeManagerConfiguration {
          # Explicitly pass our patched pkgs set to Home Manager.
          pkgs = pkgs;
          extraSpecialArgs = {
            inherit inputs outputs dotfiles helpers;
            userConfig = users.${username};
            nhModules = "${self}/modules/home-manager";
            dotfilesDir = "${self}/dotfiles";
          };
          modules = [
            ./home/${username}/${hostname}
            catppuccin.homeModules.catppuccin
          ];
        };
    in
    {
      inherit helpers;

      nixosConfigurations = {
        nix-desktop =  mkNixosConfiguration "nix-desktop" "khernand";
      };

      homeConfigurations = {
        "khernand@nix-desktop" = mkHomeConfiguration "x86_64-linux" "khernand" "nix-desktop";
      };

      dotfiles = dotfiles;
    };
}