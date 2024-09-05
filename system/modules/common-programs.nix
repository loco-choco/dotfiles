{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    #terminal tools
    fastfetch
    wget
    imagemagick
    just
    xclip
    timg
    w3m
    jq
    wine
    unzip
    zip
    android-file-transfer
    #misc
    #openscad
    #freecad
    #ltspice
    anydesk
    obs-studio
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
    logseq
    nixfmt-rfc-style
  ];
}
