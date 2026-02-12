{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.services.virtualisation;
in
{
  options = {
    systems.services.virtualisation = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables virtualisation with QEMU 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.qemu
      pkgs.quickemu
    ];
  };
}
