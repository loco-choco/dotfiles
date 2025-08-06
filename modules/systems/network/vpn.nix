{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.network.vpn;
in
{
  options = {
    systems.network.vpn = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables VPN 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    services.mullvad-vpn.enable = true;
    programs.openvpn3.enable = true;
  };
}
