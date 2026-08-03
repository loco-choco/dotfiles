{ modules, config, lib, pkgs, ... }:
{
  imports = [
    modules.niri
    modules.hyprland

    ./hardware-configuration.nix
  ];
  
  ## Minimal === 
  ##              Device Manager = mdevd
  ##              Seat   Manager = seatd
  ##              Wifi   Manager = iwd
  profiles.laptop.enable = true;
  profiles.laptop.hardwareSupport = "standard"; # TODO go back to minimal
  boot.loader.efi.canTouchEfiVariables = true;

  ## Hardware Specifics Configuration ##

  ### NVIDIA Drivers (GTX1070)
  hardware.nvidia = {
    enable = true;
    modesetting.enable = true;
    kernelModule = "closed";
    package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
  };
  ### NVIDIA Prime
  hardware.nvidia.prime = {
    offload.enable = true;
    intelBusId =  "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };
  hardware.nvidia.power.runtime.enable = true;

  hardware.graphics = {
    enable    = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libva-vdpau-driver
      libvdpau-va-gl
      nvidia-vaapi-driver
    ];
  };

  ## Desktop Configuration ##

  ### Niri 

  programs.regreet.enable = false;
  services.ly.enable = true;

  programs.niri.enable = true;
  programs.hyprland.enable = true;

  ## Users Configuration ##
  users.users.locochoco = {
    isNormalUser = true;
    extraGroups =    
      [ "wheel" "video" "audio" ]
      ++ lib.optionals config.services.networkmanager.enable [ "networkmanager" ]
      ++ lib.optionals config.services.seatd.enable [ config.services.seatd.group ];
    shell = pkgs.nushell;
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
    ## Communication
    vesktop
    ## Gaming
    steam
    ## Terminal
    wezterm        
    tmux
    nushell
    ## Window Manager Experience
    fuzzel # launcher
    ## Terminal Apps
    nix-output-monitor
  ];


  # TODO:
  ## Tunnerls/SSH Configuration ##
  ### Tailscape
  ## Webbrowsing Configuration ##
  ## Gaming Configuration ##

  ## Localization Configurations ## 
  time.timeZone = "Europe/Paris";

  ## Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      charis
      noto-fonts
      nerd-fonts.fira-code
      maple-mono.NF-unhinted
    ];
  };
}

