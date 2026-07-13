{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.services.waydroid;
in
{
  options = {
    systems.services.waydroid = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables waydroid 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    virtualisation.waydroid.enable = true;
  };
}
