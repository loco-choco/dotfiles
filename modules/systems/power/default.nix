{
  config,
  lib,
  ...
}:

with lib;
let
  cfg = config.systems.power;
in
{
  options = {
    systems.power = {
      sleep.disable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Disables sleep and hibernation
        '';
      };
      management.enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables Power Management
        '';
      };
    };
  };

  config = mkMerge [
    (mkIf cfg.sleep.disable {
      systemd.sleep.extraConfig = ''
        AllowSuspend=no
        AllowHibernation=no
        AllowHybridSleep=no
        AllowSuspendThenHibernate=no
      '';
    })
    (mkIf cfg.management.enable {
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
    })
  ];
}
