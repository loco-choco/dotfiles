let
  sources = import ./npins;
  pkgs = import sources.nixpkgs { };
  lib = pkgs.lib;
in
{
  meta = {
    nixpkgs = pkgs;
  };
  defaults =
    { name, ... }:
    {
      networking.hostName = name;
    };
}
// lib.attrsets.mergeAttrsList (
  lib.mapAttrsToList (name: file-type: {
    inherit name;
    value = ./machines/${name}/configuration.nix;
  }) (builtins.readDir ./machines)
)
