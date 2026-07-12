let
  sources = import ./npins;
  nixpkgs = sources.nixpkgs;
in import "${nixpkgs}/nixos" {
  configuration = {
    ## Overlays and other nixpkgs configs
    nixpkgs = {
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
    ## Extra modules
    imports = [
      (sources.agenix + "/modules/age.nix")
      (sources.home-manager + "/nixos")
      (import sources.nvf).nixosModules.default
      #(import sources.musnix).nixosModules.musnix
      ./modules/default.nix
      ### Actual machine configuration
      ./machines/harpia/configuration.nix
    ];
    networking.hostName = "harpia";
    ## Nixpkgs local pinning 
    environment.etc.nixpkgs.source = nixpkgs;
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
  };
}
