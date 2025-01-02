{
  description = "Entrypoint flake for NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, home-manager, ... }: 
    let
      lib = nixpkgs.lib;

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
        system = "x86_64-linux"; # Replace with your architecture if necessary
        modules = [
          ./hosts/${hostName}/hardware-configuration.nix
          ./hosts/${hostName}/configuration.nix
          home-manager.nixosModules.home-manager # Import Home Manager module
        ] ++ importNixFiles [
          ./imports/core 
          ./imports/services
          ./imports/system-programs
          ./imports/profiles
        ];
        specialArgs = {
          inherit nixpkgs home-manager; # Pass nixpkgs and home-manager to configurations
        };
      };
    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem (loadHost "desktop");
      };
    };
}
