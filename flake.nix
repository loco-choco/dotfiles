{
  description = "Ivan Pancheniak System Config";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    ow-mod-man.url = "github:ShoosGun/ow-mod-man-flake/main";
    ow-mod-man.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { nixpkgs, home-manager, hyprland, ow-mod-man, nixpkgs-unstable, ... }:
  let
    system = "x86_64-linux";
    
    ow-mod-man-overlay = final: prev: {
      owmods-cli = ow-mod-man.packages.${system}.owmods-cli;
      owmods-gui = ow-mod-man.packages.${system}.owmods-gui;
    };
    opentabletdriver-overlay = final: prev: {
      pkgs-unstable = import nixpkgs-unstable { system = final.system; };
      fixed-opentabletdriver = final.pkgs-unstable.opentabletdriver.overrideAttrs (old: {
        src = prev.fetchFromGitHub {
          owner = "loco-choco";
          repo = "OpenTabletDriver";
          rev = "hotfix";
          hash = "sha256-iiuYjO1YQxMueLhykLCGsn+45VWDJQYqybVEzYyXeJs=";
        };
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
          hyprland.homeManagerModules.default
          {
            wayland.windowManager.hyprland = {
              enable = true;
              xwayland = {
                enable = true;
                hidpi = false;
              };
              nvidiaPatches = true;
              extraConfig = ''
                exec-once=dunst
                exec-once=waybar
              '';
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

  nixConfig = {
    extra-substituters = [ "https://hyprland.cachix.org" ];
    extra-trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };
}
