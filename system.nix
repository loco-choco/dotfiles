let
  sources = import ./npins;
  finix = import sources.finix;
  community-modules = import sources.community-modules;
  laptop-profile = import sources.laptop-profile;
  nixpkgs = sources.nixpkgs;
  ## QS Niri Integration Plugin
  qml-niri = sources.qml-niri;
  ## Overlays and other nixpkgs configs
  pkgs = import nixpkgs { 
    ## TODO Make all this more generic
    system = "x86_64-linux";
    config.allowUnfree = true;
    overlays = [ (final: _: {
      game-devices-udev = final.callPackage ./game-devices-udev.nix { }; 
      qml-niri = final.callPackage (import qml-niri) { 
        version = qml-niri.version; 
      }; 
    }) ];
  }; 
  ## HJEM Initialization
  hjem = import sources.hjem { 
    pkgs = pkgs; 
    finix = finix;
  };

in finix.lib.finixSystem {
  lib = pkgs.lib;
  modules = [
    ## HJEM Module 
    hjem.finixModules.default
    ## Base Laptop Profile
    laptop-profile.nixosModules.laptop
    ## Actual machine configuration
    ./configuration.nix
    ## Base Nix/Nixpkgs Configuration
    {
      networking.hostName = "harpia";
      ## Nixpkgs local pinning
      nixpkgs.pkgs = pkgs;
      environment.variables = {
      	NIX_PATH = "nixpkgs=${nixpkgs}";
      };
      finit.package = pkgs.finit.overrideAttrs (o: {
        version = "5.0";
        src = pkgs.fetchFromGitHub {
          owner = "finit-project";
          repo = "finit";
          rev = "ad8ed05d64a4e274e39ac2d061fe8c3aa8a87c22";
          sha256 = "sha256-SJTnrcgRx/M07pOQAnm+LeiXSq9YGCON2yHLaKCMyJw=";
        };

        buildInputs = o.buildInputs ++ [ pkgs.util-linuxMinimal.dev ];

        postPatch = (o.postPatch or "") + ''
          substituteInPlace keventd/uevent.c \
            --replace-fail '"/sbin/modprobe", "modprobe"' '"${pkgs.kmod}/bin/modprobe", "modprobe"' \
            --replace-fail '"/usr/lib/firmware/' '"/run/current-system/firmware/lib/firmware/'

          substituteInPlace keventd/builtin.c \
            --replace-fail  '"/lib/udev/hwdb.d"' '"/run/current-system/sw/lib/udev/hwdb.d"' \
            --replace-fail  '"/usr/share/hwdata/usb.ids"' '"${pkgs.hwdata}/share/hwdata/usb.ids"'
        '';
      });
    }
  ];
}
