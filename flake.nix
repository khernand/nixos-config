{
  description = "Entrypoint flake for NixOS configurations";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    agenix.url = "github:ryantm/agenix";

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

    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    secrets = {
      url = "git+ssh://git@github.com/khernand/nix-secrets.git";
      flake = false;
    };
    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = 
  { 
    self,
    agenix,
    catppuccin,
    darwin,
    home-manager,
    nix-homebrew,
    homebrew-bundle, 
    homebrew-core, 
    homebrew-cask,
    flake-utils,
    nixpkgs,
    niri-flake,
    secrets,
    dotfiles,
    chaotic,
    ... 
  }@ inputs: let
      inherit (self) outputs; 
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
          specialArgs = {
            inherit inputs outputs hostname helpers;
            userConfig = users.${username};
            nixosModules = "${self}/modules/nixos";
            dotfilesDir = "${self}/dotfiles";
          };
          modules = [
            ./hosts/${hostname}
            chaotic.homeManagerModules.default
          ]; 
        };

      # Function for Home Manager configuration
      mkHomeConfiguration = system: username: hostname:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {inherit system;};
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

            ## BEGIN DARWIN TEST --
      darwinSystems = [ "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs (darwinSystems) f;
      user = "khernand";

      mkApp = scriptName: system: {
        type = "app";
        program = "${(nixpkgs.legacyPackages.${system}.writeScriptBin scriptName ''
          #!/usr/bin/env bash
          PATH=${nixpkgs.legacyPackages.${system}.git}/bin:$PATH
          echo "Running ${scriptName} for ${system}"
          exec ${self}/apps/${system}/${scriptName}
        '')}/bin/${scriptName}";
      };

      mkDarwinApps = system: {
        "apply" = mkApp "apply" system;
        "build" = mkApp "build" system;
        "build-switch" = mkApp "build-switch" system;
        "copy-keys" = mkApp "copy-keys" system;
        "create-keys" = mkApp "create-keys" system;
        "check-keys" = mkApp "check-keys" system;
        "rollback" = mkApp "rollback" system;
      };

      darwinConfigurations = nixpkgs.lib.genAttrs darwinSystems (system:
        darwin.lib.darwinSystem {
          inherit system;
          specialArgs = inputs // { inherit user; };
          modules = [
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                inherit user;
                enable = true;
                taps = {
                  "homebrew/homebrew-core" = homebrew-core;
                  "homebrew/homebrew-cask" = homebrew-cask;
                  "homebrew/homebrew-bundle" = homebrew-bundle;
                };
                mutableTaps = false;
                autoMigrate = true;
              };
            }
            ./hosts/darwin
          ];
        }
      );
      ## END DARWIN TEST --

      nixosConfigurations = {
        nix-desktop =  mkNixosConfiguration "nix-desktop" "khernand";
      };

      homeConfigurations = {
        "khernand@nix-desktop" = mkHomeConfiguration "x86_64-linux" "khernand" "nix-desktop";
      };

      dotfiles = dotfiles;
    };
}
