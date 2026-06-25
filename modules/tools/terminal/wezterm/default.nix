{
  config,
  lib,
  ...
}:

with lib;
let
  cfg = config.tools.terminal.wezterm;
in
{
  options = {
    tools.terminal.wezterm = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables wezterm 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.locochoco = {
      programs.wezterm = {
        enable = true;
        settings = {
          color_scheme = "N0tch2k";
          font_size = 11;
          hide_tab_bar_if_only_one_tab = true;
          window_padding = {
            left = 0;
            right = 0;
            top = 0;
            bottom = 0;
          };
          font = lib.generators.mkLuaInline ''wezterm.font("Maple Mono NF", { weight = 'Bold' })'';
        };
      };
    };
  };
}
