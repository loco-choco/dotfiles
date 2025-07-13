{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.development.git;
in
{
  options = {
    tools.development.git = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables git 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.locochoco = {
      programs.git = {
        enable = true;
        userName = "loco-choco";
        userEmail = "contact@locochoco.dev";
      };
    };
  };
}
