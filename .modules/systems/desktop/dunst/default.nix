{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.desktop.dunst;
in
{
  options = {
    systems.desktop.dunst = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables dunst 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.locochoco = {
      services.dunst = {
        enable = true;
        settings = {
          global = {
            width = 10000;
            height = 75;
            offset = "0x0";
            horizontal_padding = 24;
            progress_bar = false;
            notification_limit = 1;
            origin = "bottom-left";
            layer = "overlay";
            transparency = 0;
            frame_width = 0;
            background = "#000000";
            font = "FiraCode Nerd Font Mono Bold 15";
          };

          urgency_normal = {
            foreground = "#a9a4b2";
            timeout = 5;
          };
        };
      };
    };
  };
}
