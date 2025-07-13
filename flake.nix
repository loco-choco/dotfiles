{
  description = "Ivan Pancheniak System Config";

  inputs = {
    #nixpkgs.url = "github:Scrumplex/nixpkgs/nixos-monado";
    #nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "nixpkgs/master";
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
  outputs =
    {
      nixpkgs,
      home-manager,
      ow-mod-man,
      loconix,
      nixvim,
      agenix,
      ...
    }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          permittedInsecurePackages = [
            "openssl-1.1.1w"
            "electron-27.3.11"
          ];
        };

        overlays = [
          ow-mod-man.overlays.default
          loconix.overlay.wineApps
          loconix.overlay.erosanix-lib
        ];
      };

      lib = nixpkgs.lib;

      modules = [
        agenix.nixosModules.default
        home-manager.nixosModules.home-manager
        nixvim.nixosModules.nixvim
      ];

    in
    {
      nixosConfigurations = {
        locopc = lib.nixosSystem {
          inherit system;
          inherit pkgs;
          modules = [ ./machines/locopc/configuration.nix ] ++ modules;
        };
        locotop = lib.nixosSystem {
          inherit system;
          inherit pkgs;
          modules = [ ./machines/locotop/configuration.nix ] ++ modules;
        };
        locoware = lib.nixosSystem {
          inherit system;
          inherit pkgs;
          modules = [ ./machines/locoware/configuration.nix ] ++ modules;
        };
      };

      nixConfig = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
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
