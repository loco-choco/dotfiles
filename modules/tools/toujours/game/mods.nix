{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.toujours.game.mods;
in
{
  options = {
    tools.toujours.game.mods = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables mod managers
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      owmods-cli
      r2modman
      everest-mons
      archipelago
    ];
  };
}
