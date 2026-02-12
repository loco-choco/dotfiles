{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.hardware.sdr.rtl-sdr;
in
{
  options = {
    hardware.sdr.rtl-sdr = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables RTL-SDR Drivers 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    hardware.rtl-sdr.enable = true;
  };
}
