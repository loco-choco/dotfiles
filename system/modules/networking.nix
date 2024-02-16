{ config, pkgs, ... }: {
  hardware.bluetooth.powerOnBoot = true;
  hardware.bluetooth.enable = true;
  
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    # allowedTCPPortRanges = [ ];
    # allowedUDPPortRanges = [ ];
  };
}
