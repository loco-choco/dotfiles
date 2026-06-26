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
  harpia = import ./machines/harpia/configuration.nix;
}
