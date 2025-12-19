{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.toujours.social;
in
{
  options = {
    tools.toujours.social = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables social tools
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.locochoco.vesktop.enable = true;
  };
}
