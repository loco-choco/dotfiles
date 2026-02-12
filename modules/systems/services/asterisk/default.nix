{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.services.asterisk;
in
{
  options = {
    systems.services.asterisk = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables asterisk 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    services.asterisk.enable = true;
  };
}
