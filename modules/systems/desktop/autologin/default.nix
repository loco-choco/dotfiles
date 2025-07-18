{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.desktop.autologin;
in
{
  options = {
    systems.desktop.autologin = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables autologin 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    services.displayManager.autoLogin = {
      enable = true;
      user = "locochoco";
    };
  };
}
