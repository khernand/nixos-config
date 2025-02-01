{
  description = "Entrypoint flake for NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    dotfiles.url = "github:khernand/dotfiles";
  };

  outputs = { self, nixpkgs, home-manager, dotfiles, ... }: 
    let
      lib = nixpkgs.lib;

      # Define the system architecture
      system = "x86_64-linux";

      # Import all valid .nix files from a directory
      filterNixFiles = k: v: v == "regular" && lib.hasSuffix ".nix" k;

      importNixFilesFromDir = path:
        (lib.lists.forEach (lib.mapAttrsToList (name: _: path + ("/" + name))
          (lib.filterAttrs filterNixFiles (builtins.readDir path))))
        import;

      # Import from multiple directories
      importNixFiles = dirs:
        lib.flatten (lib.map (dir: importNixFilesFromDir dir) dirs);

      loadHost = hostName: {
        system = system;
        modules = [
          home-manager.nixosModules.home-manager  
          ./hosts/${hostName}/hardware-configuration.nix
          (import ./hosts/${hostName}/configuration.nix)
        ] ++ importNixFiles [
          ./imports/core 
          ./imports/services
          ./imports/system-programs
        ];
        specialArgs = {
          inherit nixpkgs home-manager dotfiles;
          # Define the user configuration which will use /profiles/${userName}.nix as home manager profile
          userName = "khernand";
          userDescription = "Kevin Hernandez";
          networkingHostName = "nixos"; 
        };
      };
    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem (loadHost "desktop");
      };

      dotfiles = dotfiles;
    };
}
