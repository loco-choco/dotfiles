{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.science.spice;
in
{
  options = {
    tools.science.spice = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables spice simulation tools 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ngspice
      xyce
    ];
  };
}
