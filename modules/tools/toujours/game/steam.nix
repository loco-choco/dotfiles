{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.toujours.game.steam;
in
{
  options = {
    tools.toujours.game.steam = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables steam 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}
