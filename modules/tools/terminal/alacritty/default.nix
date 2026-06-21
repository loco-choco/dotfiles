{
  config,
  lib,
  ...
}:

with lib;
let
  cfg = config.tools.terminal.alacritty;
in
{
  options = {
    tools.terminal.alacritty = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables alacritty 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.locochoco = {
      programs.alacritty = {
        enable = true;
        theme = "gruvbox_material_soft_dark";
        settings = {
          font.normal.family = "Maple Mono NF";
        };
      };
    };
  };
}
