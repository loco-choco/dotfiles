{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.network.tailscale;
in
{
  options = {
    systems.network.tailscale = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables Tailscale 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    services.tailscale = {
      enable = true;
    };
  };
}
