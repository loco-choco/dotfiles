{ modules, config, lib, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];
  
  ## Minimal === 
  ##              Device Manager = mdevd
  ##              Seat   Manager = seatd
  ##              Wifi   Manager = iwd
  profiles.laptop.hardwareSupport = "minimal";
}

