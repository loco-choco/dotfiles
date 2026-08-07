let
  mkFont = import ./mkFont.nix;
in
{ modules, config, lib, pkgs, ... }:
{
  imports = [
    modules.dhcpcd
    modules.openssh
    modules.niri
    modules.hyprland
    modules.ly
    modules.xwayland-satellite

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
  services.dhcpcd.enable = true; ## Ethernet
  boot.kernelModules = [ "uhid" ]; ## BLE Mouse Connection

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

  ## Pipewire Extras
  programs.pipewire = {
    alsa.enable = true;
    jack.enable = true;
  };

  ## Desktop Configuration ##

  ### Niri 

  programs.regreet.enable = false;
  services.ly.enable = true;

  programs.niri.enable = true;
  ##### XWayland
  programs.xwayland-satellite.enable = true;

  #### XDG Portals
  xdg.portal.portals = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
  ];

  #### XDG Icons
  xdg.icons.enable = true;
  #### XDG Mime
  xdg.mime.enable = true;
  xdg.mime.defaultApplications = {
    "application/pdf" = "firefox.desktop";
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/about" = "firefox.desktop";
    "x-scheme-handler/unknown" = "firefox.desktop";
  }; 

  ## Users Configuration ##
  users.users.locochoco = {
    isNormalUser = true;
    extraGroups =    
      [ "wheel" "video" "audio" "render" "input" ]
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
      ## Quickshell 
      ".config/quickshell".source = ./quickshell;
      # Custom Cursor Theme
      #".icons/default".source = "${pkgs.comixcursors.White}/share/icons/ComixCursors-White"; 
      #".local/share/icons/default".source = "${pkgs.comixcursors.White}/share/icons/ComixCursors-White"; 
      # Wallpaper
      ".wallpaper.png".source = pkgs.fetchurl {
	  url = "https://64.media.tumblr.com/7b2a35edb112458d08e35ca325a0ff44/d00014da2c3e6563-37/s2048x3072/1f535d63af44413c3fefc6d070a2830675b47634.pnj";
	  hash = "sha256-gr1lYMwKbGiKfG9KeLFmrdPI24THElMMZDTemQJOUXc=";
      };
    };
  };

  ## Packages ##
  environment.systemPackages = with pkgs; [
    ## Browser
    firefox
    ## File Browser
    nautilus
    ## Communication
    vesktop
    ## Gaming
    steam
    ## Terminal
    wezterm        
    tmux
    nushell
    ## Shell
    busybox
    just
    git
    jujutsu
    npins
    neovim
    timg
    mpv
    gpu-screen-recorder
    ## Window Manager Experience
    fuzzel # launcher
    (quickshell.overrideAttrs (prev: { buildInputs = prev.buildInputs ++ [qml-niri]; })) # Quickshell
    awww # Wallpaper
    comixcursors.White # Cursor Theme
    ## Terminal Apps
    nix-output-monitor
    ## Bluetooth Client
    bluetui
    ## SSH
    sshfs ## Fuse SSH mount
  ];


  # TODO:
  ## Tunnerls/SSH Configuration ##
  services.openssh.enable = true;
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
      ### Beastieball fonts
      (callPackage mkFont { 
        src = fetchzip {
	  url = "https://dl.dafont.com/dl/?f=hauser";
	  hash = "sha256-tV+v2geQyJiC2I1hsMjIbMBKDiv0Gou1ixIRSdke37s="; 
	  extension = "zip";
	  stripRoot = false;
	}; 
	pname = "hauser" ;
      })
      (callPackage mkFont { 
        src = fetchzip {
	  url = "https://dl.dafont.com/dl/?f=sports_jersey";
	  hash = "sha256-BLxipGxwkkzrPueSSizHEVmCV6lSPM0x5Nfnc8CqofU="; 
	  extension = "zip";
	  stripRoot = false;
	}; 
	pname = "sports-jersey" ;
      })
      (callPackage mkFont { 
        src = fetchzip {
	  url = "https://dl.dafont.com/dl/?f=sf_sports_night";
	  hash = "sha256-7oeMTrxuzWCqbykYWYPD5s/a503osQfEn/+KVfEf72k="; 
	  extension = "zip";
	  stripRoot = false;
	}; 
	pname = "sf-sports-night" ;
      })
      (callPackage mkFont { 
        src = fetchzip {
	  url = "https://dl.dafont.com/dl/?f=go_banana";
	  hash = "sha256-pLODlJUfB1Dqae/pKM4W6sSpUuxy+ZlkP0OBcOwJTbo="; 
	  extension = "zip";
	  stripRoot = false;
	}; 
	pname = "go-banana" ;
      })
    ];
  };
}

