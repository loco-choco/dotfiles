{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.power.management;
in
{
  options = {
    systems.power.management = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables Power Management
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    services.tlp = {
      enable = true;
      settings = {
        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        PLATFORM_PROFILE_ON_AC = "balanced";
        PLATFORM_PROFILE_ON_BAT = "low-power";
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 0;
      };
    };
  };
}
