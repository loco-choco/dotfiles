{ modules, config, lib, pkgs, ... }:
let
  mkFont = import ../../lib/mkFont.nix;
  dotnet = (
    with pkgs.dotnetCorePackages;
    combinePackages [
      sdk_9_0
      sdk_10_0
    ]
  );
in
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
  
  ## minimal === 
  ##              Device Manager = (mdevd) keventd
  ##              Seat   Manager = seatd & elogind
  ##              Wifi   Manager = iwd
  profiles.laptop.enable = true;
  profiles.laptop.hardwareSupport = "standard";

  ## Boot Stuff
  boot.loader.efi.canTouchEfiVariables = true;
  hardware.console.keyMap = "fr";
  programs.limine.settings = {
    wallpaper = [
      (pkgs.fetchurl {
        url = "https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/3960600/bc8e7cdc4964f03e61c427b91efd357e2e677825/library_hero_2x.jpg";
        hash = "sha256-F5ULSTHimUM/LAMxsW8UmPV9FkOPMfqe5Fe452pAyho=";
      })
    ];
	 wallpaper_style = "centered";
  };
  ## Hardware Specifics Configuration ##
  ### Device Management
  # services.mdevd.enable = lib.mkForce false;
  # services.keventd.enable = true;
  ### Wifi Management
  services.networkmanager.enable = lib.mkForce false;
  services.iwd.enable = lib.mkForce true;
  ### Session Management
  # services.elogind.enable = lib.mkForce true;
  ### Ethernet Management
  # services.dhcpcd.enable = true; ## Ethernet
  ### Kernel Modules for specific hardware
  boot.kernelModules = [ "uhid" ]; ## BLE Mouse Connection

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
  programs.niri.enable = true;

  programs.regreet.enable = false;
  services.ly.enable = true;

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
  users.users =  {
    locochoco = {
      isNormalUser = lib.mkDefault true;
      extraGroups = [ 
        "video" "audio" "render" "input" "uinput" "plugdev" 
    	  "wheel" config.services.seatd.group 
      ]; ## render - use gpu guy 
      shell = pkgs.nushell;
    };
  };

  users.groups.plugdev = { };

  hardware.uinput.enable = true;

  ## HJEM Configuration ##
  hjem.users.locochoco = {
    directory = "/home/locochoco"; 
    files = {
      ## Niri
      ".config/niri".source = ../../niri;
      ## Wezterm 
      ".config/wezterm".source = ../../wezterm;
      ## Neovim
      ".config/nvim".source = ../../nvim;
      ## Quickshell 
      ".config/quickshell".source = ../../quickshell;
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
	 ungoogled-chromium
    thunderbird
    ## Maps
    comaps
    ## File Browser
    nautilus
    ## Communication
    vesktop
    ## Gaming
    steam
	 owmods-cli
    ## Art
    inkscape
	 ## Music
	 musescore
    ## Terminal
    wezterm        
    tmux
    nushell
	 # Java JARs
	 jdk
    ## Shell
    busybox
    gnumake # make
    gcc # cc
    rustup
    just
    git
    jujutsu
    npins
    neovim
    timg
    numbat
	 ffmpeg
    mpv
	 typst
    kdePackages.kompare
    gpu-screen-recorder
    btop
	 ## Video Recording
obs-studio
    ## Window Manager Experience
    fuzzel # launcher
    quickshell
    awww # Wallpaper
    dragon-drop
    comixcursors.White # Cursor Theme
	 sox # play - sfx
    ## Terminal Apps
    nix-output-monitor
	 nh
    ## Bluetooth Client
    bluetui
	 bluez-tools
    ## SSH
    sshfs ## Fuse SSH mount
    ## Neovim Plugins External Dependencies
    ### Telescope
    ripgrep # rg
    fd # fd
    ### Treesitter
    tree-sitter
    # (tree-sitter.withPlugins (p: [ p.tree-sitter-c p.tree-sitter-lua p.tree-sitter-fstar ]))
    ### FStar.nvim
    ### Dotnet and dotnet lsp
    dotnet
    csharp-ls
    ### Rust
    # rustup
    ### VHDL
    ghdl
	 gtkwave
    vhdl-ls
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
