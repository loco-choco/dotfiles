{ config, pkgs, ... }: {
  enviroment.systemPackages = with pkgs; [
    #terminal tools
    neofetch
    wget
    xclip
    w3m
    jq
    wine
    unzip
    zip
    #misc
    #openscad
    #freecad
    obs-studio
    vlc
  ];
}
