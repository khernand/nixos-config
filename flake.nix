{
  description = "Entrypoint flake for NixOS configurations";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

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

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
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
    chaotic,
    ... 
  }@ inputs: let
      inherit (self) outputs; 

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
            inherit inputs outputs hostname;
            userConfig = users.${username};
            nixosModules = "${self}/modules/nixos";
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
            inherit inputs outputs dotfiles;
            userConfig = users.${username};
            nhModules = "${self}/modules/home-manager";
          };
          modules = [
            ./home/${username}/${hostname}
            catppuccin.homeModules.catppuccin
          ]; 
        };  
    in
    {
      nixosConfigurations = {
        nix-desktop =  mkNixosConfiguration "nix-desktop" "khernand";
      };

      homeConfigurations = {
        "khernand@nix-desktop" = mkHomeConfiguration "x86_64-linux" "khernand" "nix-desktop";
      };

      dotfiles = dotfiles;
    };
}
