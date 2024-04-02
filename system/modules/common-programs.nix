{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    #terminal tools
    neofetch
    wget
    imagemagick
    just
    xclip
    w3m
    jq
    wine
    unzip
    zip
    #misc
    #openscad
    #freecad
    #ltspice
    obs-studio
    ardour
    vlc
    (prismlauncher.override { jdks = [ jdk8 jdk17 jdk19 ]; })
  ];
}
