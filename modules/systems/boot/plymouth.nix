{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.boot.plymouth;
in
{
  options = {
    systems.boot.plymouth = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables plymouth 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    boot = {
      plymouth = {
        enable = true;
        theme = "blahaj";
        themePackages = [ pkgs.plymouth-blahaj-theme ];
      };

      consoleLogLevel = 3;
      initrd.verbose = false;

      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "udev.log_priority=3"
        "rd.systemd.show_status=auto"
      ];

      ### Hide OS Selection
      loader.timeout = 0;
    };
  };
}
