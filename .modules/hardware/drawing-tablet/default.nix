{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.hardware.drawing-tablet;
in
{
  options = {
    hardware.drawing-tablet = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables Drawing Tablets Driver
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    hardware.opentabletdriver.enable = true;
  };
}
