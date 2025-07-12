{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.development.arduino;
in
{
  options = {
    tools.development.arduino = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables arduino's development tools 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      arduino-cli
    ];
  };
}
