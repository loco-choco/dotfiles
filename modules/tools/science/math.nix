{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.science.math;
in
{
  options = {
    tools.science.math = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables math related tools 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (octaveFull.withPackages (p: [
        p.signal
      ]))
    ];
  };
}
