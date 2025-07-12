{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.hardware.keyboard.us-int;
in
{
  options = {
    hardware.keyboard.us-int = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables us-int keyboard 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };
}
