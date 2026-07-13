let
  sources = import ./npins;
  finix = import sources.finix;
  ## Overlays and other nixpkgs configs
  pkgs = import sources.nixpkgs { };
in finix.lib.finixSystem {
  modules = [
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
  ];
}
