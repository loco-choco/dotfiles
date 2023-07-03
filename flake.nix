{
  description = "Ivan Pancheniak System Config";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    ow-mod-man.url = "github:ShoosGun/ow-mod-man-flake/main";
    ow-mod-man.inputs.nixpkgs.follows = "nixpkgs";
    loconix.url = "github:loco-choco/loconix/main";
    loconix.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { nixpkgs, home-manager, ow-mod-man, loconix, nixpkgs-unstable, ... }:
  let
    system = "x86_64-linux";
    
    loconix-overlay = final: prev: {
      ltspice = loconix.packages.${system}.ltspice;
    };
    ow-mod-man-overlay = final: prev: {
      owmods-cli = ow-mod-man.packages.${system}.owmods-cli;
      owmods-gui = ow-mod-man.packages.${system}.owmods-gui;
    };
    unstable-pkgs-overlay = final: prev: {
      pkgs-unstable = import nixpkgs-unstable { system = final.system; };
      fixed-opentabletdriver = final.pkgs-unstable.opentabletdriver.overrideAttrs (old: {
        src = prev.fetchFromGitHub {
          owner = "loco-choco";
          repo = "OpenTabletDriver";
          rev = "hotfix";
          hash = "sha256-iiuYjO1YQxMueLhykLCGsn+45VWDJQYqybVEzYyXeJs=";
        };
      });
      unityhub = final.pkgs-unstable.unityhub;
    };

    pkgs = import nixpkgs {
      inherit system;
      config = { 
        allowUnfree = true;
      };
      overlays = [ ow-mod-man-overlay unstable-pkgs-overlay loconix-overlay];
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
