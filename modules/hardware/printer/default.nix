{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.hardware.printer;
in
{
  options = {
    hardware.printer = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables CUPS Printers 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    services.printing.enable = true;
    services.printing.browsed.enable = true;
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
