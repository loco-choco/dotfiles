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

  ## Hardware Specifics Configuration ##

  ### NVIDIA Drivers (GTX1070)

  ### NVIDIA Prime

  ## Desktop Configuration ##

  ### Niri 


  ## Terminal Configuration ##

  ## Neovim Configuration ##

  ## Tunnerls/SSH Configuration ##

  ### Tailscape

  ## Webbrowsing Configuration ##

  ## Gaming Configuration ##

  ## 
}

