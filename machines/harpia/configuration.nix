{ modules, config, lib, pkgs, ... }:
{
  imports = [
    modules.niri

    ./hardware-configuration.nix
  ];
  
  ## Minimal === 
  ##              Device Manager = mdevd
  ##              Seat   Manager = seatd
  ##              Wifi   Manager = iwd
  profiles.laptop.hardwareSupport = "minimal";

  ## Hardware Specifics Configuration ##

  ### NVIDIA Drivers (GTX1070)
  hardware.nvidia = {
    enable = true;
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  };
  ### NVIDIA Prime
  # Waiting for github.com/finix-community/finix/pull/128/
  #hardware.nvidia.prime = {
  #  sync.enable = true;
  #  intelBusId =  "PCI:0:2:0";
  #  nvidiaBusId = "PCI:1:0:0";
  #};

  ## Desktop Configuration ##

  ### Niri 
  programs.niri.enable = true;

  ## Terminal Configuration ##

  ## Neovim Configuration ##

  ## Tunnerls/SSH Configuration ##

  ### Tailscape

  ## Webbrowsing Configuration ##

  ## Gaming Configuration ##

  ## 
}

