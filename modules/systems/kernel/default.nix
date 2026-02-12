{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.kernel;
in
{
  options = {
    systems.kernel = {
      latest.enable = mkOption {
        default = true;
        type = types.bool;
        description = ''
          Enables the latest Linux kernel 
        '';
      };
      zen.enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables the zen Linux kernel 
        '';
      };
    };
  };

  config = mkMerge [
    {
      assertions = [
        {
          assertion = !(config.systems.kernel.latest.enable && config.systems.kernel.zen.enable);
          message = ''
            Can't have multiple kernels enabled
          '';
        }
      ];
    }
    (mkIf cfg.latest.enable {
      boot.kernelPackages = pkgs.linuxPackages_latest;
    })
    (mkIf cfg.zen.enable {
      boot.kernelPackages = pkgs.linuxPackages_zen;
    })

  ];
}
