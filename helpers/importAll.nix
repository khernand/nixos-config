{ lib }:

let
  inherit (builtins) readDir match import;
  inherit (lib) mapAttrsToList concatLists;

  # Recursive function to import all .nix files in a directory and its subdirectories
  importAll = path:
    let
      entries = readDir path;

      modules = mapAttrsToList (name: type:
        let
          fullPath = "${path}/${name}";
        in
          if type == "directory" then
            importAll fullPath
          else if type == "regular" && match ".*\\.nix$" name != null then
            [ (import fullPath) ]
          else
            []
      ) entries;
    in
      concatLists modules;
in
  importAll
