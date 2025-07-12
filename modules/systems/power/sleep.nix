{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.power.sleep;
in
{
  options = {
    systems.power.sleep = {
      disable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Disables sleep and hibernation
        '';
      };
    };
  };

  config = mkIf cfg.disable {
    systemd.sleep.extraConfig = ''
      AllowSuspend=no
      AllowHibernation=no
      AllowHybridSleep=no
      AllowSuspendThenHibernate=no
    '';
  };
}
