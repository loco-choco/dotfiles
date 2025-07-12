{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.font.nerd-font;
in
{
  options = {
    systems.font.nerd-font = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Adds nerd font 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    fonts.packages = with pkgs; [ nerd-fonts.fira-code ];
  };
}
