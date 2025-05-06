{ config, pkgs, ... }:
{
  programs.obs-studio = {
    enable = true;
    plugins = [ pkgs.obs-studio-plugins.obs-livesplit-one ];
  };
  environment.systemPackages = with pkgs; [
    #terminal tools
    fastfetch
    wget
    imagemagick
    just
    xclip
    timg
    w3m
    quickemu
    jq
    wine
    unzip
    zip
    android-file-transfer
    #misc
    #openscad
    #freecad
    #ltspice
    /*
      (sm64coopdx.overrideAttrs {
        version = "1.1.1";
        src = fetchFromGitHub {
          owner = "coop-deluxe";
          repo = "sm64coopdx";
          rev = "v1.1.1";
          hash = "sha256-ktdvzOUYSh6H49BVDovqYt5CGyvJi4UW6nJOOD/HGGU=";
        };
      })
    */
    ardour
    vlc
    (prismlauncher.override {
      jdks = [
        jdk8
        jdk17
      ];
    })
    sioyek
    todoman
    vdirsyncer
  ];
}
