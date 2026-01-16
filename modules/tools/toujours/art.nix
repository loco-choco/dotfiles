{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.toujours.art;
in
{
  options = {
    tools.toujours.art = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables art tools
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      aseprite
      blender
      inkscape
      krita
      gimp
    ];
  };
}
