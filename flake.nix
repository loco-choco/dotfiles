{
  description = "Ivan Pancheniak System Config";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    ow-mod-man.url = "github:ShoosGun/ow-mod-man-flake/main";
    ow-mod-man.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { nixpkgs, home-manager, ow-mod-man, ... }@inputs:
  let
    system = "x86_64-linux";
    
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };
    
    lib = nixpkgs.lib;

  in {
    homeConfigurations = {
      locochoco = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs.inputs = inputs;

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

        modules = [
          ./system/configuration.nix
        ];
      };
    };
  };
}
