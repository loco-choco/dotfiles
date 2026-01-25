{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.kernel.latest;
in
{
  options = {
    systems.kernel.latest.enable = mkOption {
      default = false;
      type = types.bool;
      description = ''
        Enables the latest Linux kernel 
      '';
    };
  };

  config = mkIf cfg.enable {
    boot.kernelPackages = pkgs.linuxPackages_latest;
  };
}
