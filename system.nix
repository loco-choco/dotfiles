let
  sources = import ./npins;
  finix = import sources.finix;
  community-modules = import sources.community-modules;
  ## Overlays and other nixpkgs configs
  pkgs = import sources.nixpkgs { 
    ## TODO Make all this more generic
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in finix.lib.finixSystem {
  lib = pkgs.lib;
  modules = [
    ## Base Laptop Profile
    community-modules.nixosModules.laptop
    ## Actual machine configuration
    ./machines/harpia/configuration.nix
    ## Base Nix/Nixpkgs Configuration
    {
      networking.hostName = "harpia";
      ## Nixpkgs local pinning
      nixpkgs.pkgs = pkgs;
    }
  ];
}
