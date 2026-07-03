let
  sources = import ./npins;
  finix = import sources.finix;
  ## Overlays and other nixpkgs configs
  pkgs = import sources.nixpkgs {
      config = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "openssl-1.1.1w"
          "electron-36.9.5"
          "libxml2-2.13.8"
          "dotnet-sdk-6.0.428"
          "dotnet-sdk-7.0.410"
          "segger-jlink-qt4-874"
        ];
        segger-jlink.acceptLicense = true;
      };
      overlays = [
        (import (sources.agenix + "/overlay.nix"))
        (final: _: { nh = final.callPackage (sources.nh + "/package.nix") { }; })
      ];
    };
in finix.lib.finixSystem {
  lib = pkgs.lib;
  modules = [
    ## Extra Modules
    (sources.agenix + "/modules/age.nix")
    (sources.home-manager + "/nixos")
    (import sources.nvf).nixosModules.default
    #(import sources.musnix).nixosModules.musnix
    ## Local Modules 
    ./modules/default.nix
    ## Actual machine configuration
    ./machines/harpia/configuration.nix
    ## Base Nix/Nixpkgs Configuration
    {
      networking.hostName = "harpia";
      ## Nixpkgs local pinning
      nixpkgs.pkgs = pkgs;
      environment.etc.nixpkgs.source = pkgs;
      nix.nixPath = [ 
        "nixos-config=${toString ./machines/harpia/configuration.nix}"
        "nixpkgs=/etc/nixpkgs"
      ];
      ## Extra cachix caching
      nix.settings = {
        extra-substituters = [
          "https://ow-mods.cachix.org"
          "https://nix-community.cachix.org"
        ];
        extra-trusted-public-keys = [
          "ow-mods.cachix.org-1:6RTOd1dSRibA2W0MpZHxzT0tw1RzyhKObTPKQJpcrZo="
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };
    }
  ] ## Fenix Modules
  ++ builtins.attrValues finix.nixosModules;
}
