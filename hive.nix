let
  sources = import ./npins;
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
    ];
  };
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
        (import sources.nixvim).nixosModules.nixvim
        (import sources.musnix).nixosModules.musnix
        ./modules/default.nix
      ];
      networking.hostName = name;
    };
  harpia = ./machines/harpia/configuration.nix;
}
