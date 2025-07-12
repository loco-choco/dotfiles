{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.desktop.rofi;
in
{
  options = {
    systems.desktop.rofi = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables rofi 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      terminal = "${pkgs.kitty}/bin/kitty";
      font = "FiraCode Nerd Font Mono 15";
      theme = ./theme.rasi;
    };
  };
}
