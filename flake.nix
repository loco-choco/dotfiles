{
  description = "Ivan Pancheniak System Config";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    ow-mod-man.url = "github:ShoosGun/ow-mod-man-flake/main";
    ow-mod-man.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { nixpkgs, home-manager, ow-mod-man, ... }:
  let
    system = "x86_64-linux";
    
    ow-mod-man-overlay = final: prev: {
      owmods-cli = ow-mod-man.packages.${system}.owmods-cli;
      owmods-gui = ow-mod-man.packages.${system}.owmods-gui;
    };
    opentabletdriver-overlay = final: prev: {
      fixed-opentabletdriver = prev.opentabletdriver.overrideAttrs (old: {
        src = prev.fetchFromGitHub {
          owner = "loco-choco";
          repo = "OpenTabletDriver";
          rev = "master";
          hash = "sha256-CRVWAUxeLQPPT/J2iIo2np7MHX/mxyf5bsSZrvJZjvs=";
        };
        dotnetInstallFlags = [ "--framework=net7.0" ];
      });
    };

    pkgs = import nixpkgs {
      inherit system;
      config = { 
        allowUnfree = true;
      };
      overlays = [ ow-mod-man-overlay opentabletdriver-overlay ];
    };
    
    lib = nixpkgs.lib;

  in {
    homeConfigurations = {
      locochoco = home-manager.lib.homeManagerConfiguration {
        #pkgs = nixpkgs.legacyPackages.${system};
        inherit pkgs;
        modules = [
          ./users/locochoco/home.nix
          {
            home = {
              username = "locochoco";
              homeDirectory = "/home/locochoco";
            };
          }
        ];
      };
    };

    nixosConfigurations = {
      locochoco = lib.nixosSystem {
        inherit system;
        inherit pkgs;
        modules = [
          ./system/configuration.nix
        ];
      };
    };
  };
}
