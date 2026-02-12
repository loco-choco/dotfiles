{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.toujours.obs;
in
{
  options = {
    tools.toujours.obs = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables obs
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.obs-studio = {
      enable = true;
      plugins = [ pkgs.obs-studio-plugins.obs-livesplit-one ];
    };
  };
}
