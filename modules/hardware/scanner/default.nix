{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.hardware.scanner;
in
{
  options = {
    hardware.scanner = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables SANE Driver
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    hardware.sane.enable = true;
    
  };
}
