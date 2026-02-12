{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.development.game.unity;
in
{
  options = {
    tools.development.game.unity = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables godot development tools 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      unityhub
    ];
  };
}
