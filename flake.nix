{
  description = "Entrypoint flake for NixOS configurations";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs, ... }: 
    let
      lib = nixpkgs.lib;

      # Import all valid .nix files from a directory
      filterNixFiles = k: v: v == "regular" && lib.hasSuffix ".nix" k;

      importNixFiles = path:
        (lib.lists.forEach (lib.mapAttrsToList (name: _: path + ("/" + name))
          (lib.filterAttrs filterNixFiles (builtins.readDir path))))
      import;

      loadHost = hostName: {
        system = "x86_64-linux"; # Replace with your architecture if necessary
        modules = [
          ./hosts/${hostName}/hardware-configuration.nix
          ./hosts/${hostName}/configuration.nix
        ] ++ importNixFiles ./services;
      };
    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem (loadHost "desktop");
      };
    };
}