{ lib }:
let
  inherit (builtins) readDir attrNames filter match map;
in
path:
let
  fileList = attrNames (readDir path);
  nixFiles = filter (file: match ".*\\.nix$" file != null) fileList;
in map (file: import (path + "/${file}")) nixFiles
