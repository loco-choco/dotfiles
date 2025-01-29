{
  description = "Ivan Pancheniak System Config";

  inputs = {
    #nixpkgs.url = "github:Scrumplex/nixpkgs/nixos-monado";
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    #nixpkgs.url = "nixpkgs/master";
    #nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    ow-mod-man.url = "github:ow-mods/ow-mod-man/dev";
    ow-mod-man.inputs.nixpkgs.follows = "nixpkgs";
    loconix.url = "github:loco-choco/loconix/main";
    loconix.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim/main";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix";
  };
  outputs = { nixpkgs, home-manager, ow-mod-man, loconix, nixvim, agenix, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [ "openssl-1.1.1w" "electron-27.3.11" ];
        };

        overlays = [
          ow-mod-man.overlays.default
          loconix.overlay.wineApps
          loconix.overlay.erosanix-lib
        ];
      };

      lib = nixpkgs.lib;

      # TODO Make this config more modular, maybe some cool option to auto create the modules list
      # instead of imports in the configuration file
      agenix-modules = [
        {
          age.identityPaths = [ "/home/locochoco/.ssh/id_ed25519" ];
          age.secrets.github-api = {
            file = .secrets/github-api.age;
            mode = "0440";
            owner = "locochoco";
            group = "wheel";
          };
        }
        agenix.nixosModules.default
      ];

    in {
      homeConfigurations = {
        locochoco = home-manager.lib.homeManagerConfiguration {
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
      # TODO Make this config more modular, maybe some cool option to auto create the modules list
      # instead of imports in the configuration file
      nixosConfigurations = {
        locopc = lib.nixosSystem {
          inherit system;
          inherit pkgs;
          modules = [ ./system/locopc/configuration.nix ] ++ agenix-modules;
        };
        locotop = lib.nixosSystem {
          inherit system;
          inherit pkgs;
          modules = [ ./system/locotop/configuration.nix ] ++ agenix-modules;
        };
        locoware = lib.nixosSystem {
          inherit system;
          inherit pkgs;
          modules = [ ./system/locoware/configuration.nix ] ++ agenix-modules;
        };
      };

      nixConfig = {
        experimental-features = [ "nix-command" "flakes" ];
        substituters = [ "https://cache.nixos.org/" ];

        extra-substituters = [
          "https://ow-mods.cachix.org"
          # Nix community's cache server
          "https://nix-community.cachix.org"
        ];
        extra-trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "ow-mods.cachix.org-1:6RTOd1dSRibA2W0MpZHxzT0tw1RzyhKObTPKQJpcrZo="
        ];
      };

    };
}
