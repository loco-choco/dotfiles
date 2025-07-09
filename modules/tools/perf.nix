{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.perf;
in
{
  options = {
    tools.perf = {
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
    ### TODO MAKE IT KERNEL AGNOSTIC
    environment.systemPackages = with pkgs; [ linuxKernel.packages.linux_zen.perf ];
  };
}
