{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.toujours.wine;
in
{
  options = {
    tools.toujours.wine = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables wine
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wine
    ];
  };
}
