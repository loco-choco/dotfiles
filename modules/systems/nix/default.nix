{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.nix;
in
{
  options = {
    systems.nix = {
      trust = {
        all = mkOption {
          default = false;
          type = types.bool;
          description = ''
            Trust all users 
          '';
        };
        users = mkOption {
          default = [ ];
          type = lib.types.nonEmptyListOf lib.types.str;
          description = ''
            Trusted users list 
          '';
        };
      };
      github-api-path = mkOption {
        type = types.path;
        description = ''
          Path for github-api file for nix
        '';
      };
    };
  };

  config = {
    nix.settings.trusted-users =
      if cfg.trust.all then builtins.attrNames config.users.users else cfg.trust.users;
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    nix.extraOptions = ''
      !include ${cfg.github-api-path}
    '';
  };
}
