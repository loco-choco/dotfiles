let
  sources = import ./npins;
  finix = import sources.finix;
  community-modules = import sources.community-modules;
  nixpkgs = sources.nixpkgs;
  ## Overlays and other nixpkgs configs
  pkgs = import nixpkgs { 
    ## TODO Make all this more generic
    system = "x86_64-linux";
    config.allowUnfree = true;
  }; 
  ## HJEM Initialization
  hjem = import sources.hjem { 
    pkgs = pkgs; 
    finix = finix;
  };

in finix.lib.finixSystem {
  lib = pkgs.lib;
  modules = [
    ## HJEM Module 
    hjem.finixModules.default
    ## Base Laptop Profile
    community-modules.nixosModules.laptop
    ## Actual machine configuration
    ./configuration.nix
    ## Base Nix/Nixpkgs Configuration
    {
      networking.hostName = "harpia";
      ## Nixpkgs local pinning
      nixpkgs.pkgs = pkgs;
      environment.variables = {
      	NIX_PATH = "nixpkgs=${nixpkgs}";
      };
    }
  ];
}
