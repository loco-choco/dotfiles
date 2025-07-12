{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.network;
in
{
  options = {
    systems.network = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables network 
        '';
      };
      firewall = {
        enable = mkOption {
          default = true;
          type = types.bool;
          description = ''
            Enables firewall 
          '';
        };
        tcp-ports = mkOption {
          default = [ ];
          type = types.list;
          description = ''
            Allowed Tcp Ports 
          '';
        };
        udp-ports = mkOption {
          default = [ ];
          type = types.list;
          description = ''
            Allowed Udp Ports 
          '';
        };
      };
    };
  };

  config = mkIf cfg.enable {
    networking.networkmanager.enable = true;
    networking.firewall = {
      enable = cfg.firewall.enable;
      allowedTCPPortRanges = cfg.firewall.tcp-ports;
      allowedUDPPortRanges = cfg.firewall.udp-ports;
    };
  };
}
