{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.hardware.logical-analyser;
in
{
  options = {
    hardware.logical-analyser = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables Logical Analyser Driver
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.pulseview.enable = true;
  };
}
