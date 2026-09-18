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
    overlays = [ (final: _: {
      game-devices-udev = final.callPackage ./game-devices-udev.nix { }; 
    }) ];
  }; 
  ## HJEM Initialization
  hjem = import sources.hjem { 
    pkgs = pkgs; 
    finix = finix;
  };

  mkMachine = ({name, modules}: finix.lib.finixSystem {
		  lib = pkgs.lib;
		  modules = [
		    ## Base Nix/Nixpkgs Configuration
		    {
		      networking.hostName = name;
		      ## Nixpkgs local pinning
		      nixpkgs.pkgs = pkgs;
		      environment.variables = {
		      	NIX_PATH = "nixpkgs=${nixpkgs}";
		      };
		    }
		  ] ++ modules;
		}
	);
in {
	cabure = mkMachine {
		name = "cabure";
		modules = [
	   	## HJEM Module 
	   	hjem.finixModules.default
	   	## Base Laptop Profile
	   	community-modules.nixosModules.laptop
	   	## Actual machine configuration
	   	./machines/cabure/configuration.nix
	  	];
	};
	harpia = mkMachine {
		name = "harpia";
		modules = [
	   	## HJEM Module 
	   	hjem.finixModules.default
	   	## Base Laptop Profile
	   	community-modules.nixosModules.laptop
	   	## Actual machine configuration
	   	./machines/harpia/configuration.nix
	  	];
	};
}

