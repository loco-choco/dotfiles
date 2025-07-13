{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.boot.plymouth;
in
{
  options = {
    systems.boot.plymouth = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables plymouth 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    boot.plymouth = {
      enable = true;
      themePackages = [ pkgs.plymouth-blahaj-theme ];
    };
  };
}
