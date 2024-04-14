{ config, pkgs, ... }: {
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    # allowedTCPPortRanges = [ ];
    # allowedUDPPortRanges = [ ];
  };
}
