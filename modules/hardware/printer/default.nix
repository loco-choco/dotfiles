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
      deskjet.enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables DeskJet Printers 
        '';
      };
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      services.printing.enable = true;
      services.printing.browsed.enable = true;
      services.avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
    })
    (mkIf cfg.deskjet.enable {
      services.printing.drivers = [ pkgs.hplip ];
      hardware.printers = {
        ensurePrinters = [
          {
            name = "HP_DeskJet_2676";
            location = "Home";
            deviceUri = "usb://HP/DeskJet%202600%20series?serial=BR77RFB3NH06P5&interface=1";
            model = "HP/hp-deskjet_plus_6000_series.ppd.gz";
            ppdOptions = {
              PageSize = "A4";
            };
          }
        ];
      };
    })
  ];
}
