{
  description = "Ivan Pancheniak System Config";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    #nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    ow-mod-man.url = "github:ShoosGun/ow-mod-man-flake/main";
    ow-mod-man.inputs.nixpkgs.follows = "nixpkgs";
    loconix.url = "github:loco-choco/loconix/main";
    loconix.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim/main";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { nixpkgs, home-manager, ow-mod-man, loconix, nixvim, ... }:
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
      #pkgs-unstable = import nixpkgs-unstable { system = final.system; };
      #fixed-opentabletdriver = final.pkgs.opentabletdriver.overrideAttrs (old: {
      #  src = prev.fetchFromGitHub {
      #    owner = "OpenTabletDriver";
      #    repo = "OpenTabletDriver";
      #    rev = "hotfix";
      #    hash = "sha256-xVrQLFIrFkqgGua6JZReLmakaYUnR3pwKtPxjNr8Yow=";
      #  };
      #});
      #unityhub = final.pkgs-unstable.unityhub;
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
          nixvim.homeManagerModules.nixvim
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
      locopc = lib.nixosSystem {
        inherit system;
        inherit pkgs;
        modules = [
          ./system/locopc/configuration.nix
        ];
      };
      locotop = lib.nixosSystem {
        inherit system;
        inherit pkgs;
        modules = [
          ./system/locotop/configuration.nix
        ];
      };
    };
  };
}
