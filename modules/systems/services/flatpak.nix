{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.services.flatpak;
in
{
  options = {
    systems.services.flatpak = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables flatpak support 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    services.flatpak.enable = true;
  };
}
