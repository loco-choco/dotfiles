{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.bluetooth;
in
{
  options = {
    systems.bluetooth = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables bluetooth
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    hardware.bluetooth.powerOnBoot = true;
    hardware.bluetooth.enable = true;
    services.blueman.enable = true;
  };
}
