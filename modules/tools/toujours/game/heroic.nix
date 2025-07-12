{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.toujours.game.heroic;
in
{
  options = {
    tools.toujours.game.heroic = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables heroic
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      heroic
    ];
  };
}
