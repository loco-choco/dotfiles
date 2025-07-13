{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.terminal.kitty;
in
{
  options = {
    tools.terminal.kitty = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables kitty 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.locochoco = {
      programs.kitty = {
        enable = true;
        themeFile = "SpaceGray_Eighties";
        settings = {
          enabled_layouts = "*";
          font_family = "FiraCode Nerd Font";
          bell_path = builtins.toString ./sounds/Objects_RockHitA_1.wav;
        };
      };
    };
  };
}
