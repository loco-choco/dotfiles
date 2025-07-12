{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.hardware.android;
in
{
  options = {
    hardware.android = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables Android IO 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      android-file-transfer
    ];
  };
}
