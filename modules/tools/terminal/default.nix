{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.terminal;
in
{
  options = {
    tools.terminal = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables default terminal tools 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.localBinInPath = true;
    environment.systemPackages = with pkgs; [
      fastfetch
      wget
      imagemagick
      just
      timg
      w3m
      jq
      unzip
      zip
      mpv
      f3d
      bat
      xdragon
      ascii-image-converter
      ffmpeg
    ];
  };
}
