{ config, pkgs, ... }: {
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];
  hardware.printers = {
    ensurePrinters = [{
      name = "HP_DeskJet_2676";
      location = "Home";
      deviceUri =
        "usb://HP/DeskJet%202600%20series?serial=BR77RFB3NH06P5&interface=1";
      model = "HP/hp-deskjet_plus_6000_series.ppd.gz";
      ppdOptions = { PageSize = "A4"; };
    }];
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing.cups-pdf = {
    enable = true;
    instances.pdf = {
      settings = {
        Out = "\${HOME}/cups-pdf";
        UserUMask = "0033";
      };
    };
  };
}
