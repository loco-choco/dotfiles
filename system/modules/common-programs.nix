{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    #terminal tools
    fastfetch
    wget
    imagemagick
    just
    xclip
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
    (prismlauncher.override { jdks = [ jdk8 jdk17 jdk19 ]; })
    sioyek
    todoman
    vdirsyncer
    logseq
  ];
}
