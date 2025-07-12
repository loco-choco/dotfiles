{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.development.profiling.perf;
in
{
  options = {
    tools.development.profiling.perf = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables perf event paranoid
        '';
      };
      level = mkOption {
        default = -1;
        type = types.int;
        description = ''
          Perf Event Paranoid Level 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    boot.kernel.sysctl."kernel.perf_event_paranoid" = cfg.level;
    environment.systemPackages = [ config.boot.kernelPackages.perf ];
  };
}
