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
    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        charis-sil
        noto-fonts
        nerd-fonts.fira-code
        maple-mono.NF-unhinted
      ];
      fontconfig = {
        enable = true;
        defaultFonts = {
          serif = [
            "Charis SIL"
          ];
          sansSerif = [
            "Noto Sans"
          ];
          monospace = [
            "Maple Mono NF CN"
          ];
          emoji = [
            "Noto Color Emoji"
          ];
        };
      };
    };
  };
}
