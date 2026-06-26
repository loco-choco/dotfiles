let
  sources = import ./npins;
  pkgs = import sources.nixpkgs;
  lib = pkgs.lib;
in
{
  meta = {
    nixpkgs = pkgs;
  };
  defaults =
    { name, ... }:
    {
      imports = [
        (sources.agenix + "/modules/age.nix")
        (sources.home-manager + "/nixos")
        #(import sources.nixvim).nixosModules.nixvim
        #(import sources.musnix)
        ./modules/default.nix
      ];
      networking.hostName = name;
    };
  harpia = ./machines/harpia/configuration.nix;
}
