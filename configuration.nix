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
    nvidiaSettings = false;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  };
  ### NVIDIA Prime
  # TODO Go Back to main finix once the MR gets merged
  # Waiting for github.com/finix-community/finix/pull/128/
  hardware.nvidia.prime = {
    sync.enable = true;
    intelBusId =  "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  ## Desktop Configuration ##

  ### Niri 
  programs.niri.enable = true;

  ## Users Configuration ##
  users.users.locochoco = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" config.services.seatd.group ];
  };

  ## HJEM Configuration ##
  hjem.users.locochoco = {
    directory = "/home/locochoco"; 
    files = {
      ## Niri
      ".config/niri".source = ./niri;
      ## Wezterm 
      ".config/wezterm".source = ./wezterm;
      ## Neovim
      ".config/nvim".source = ./nvim;
    };
  };

  ## Packages ##
  environment.systemPackages = with pkgs; [
    ## Browser
    firefox
    ## Gaming
    steam
    ## Terminal
    wezterm        
    tmux
    nushell
    ## Window Manager Experience
    fuzzel # launcher
  ];

  # TODO:
  ## Tunnerls/SSH Configuration ##
  ### Tailscape
  ## Webbrowsing Configuration ##
  ## Gaming Configuration ##

  ## Localization Configurations ## 
  time.timeZone = "Europe/Paris";
}

