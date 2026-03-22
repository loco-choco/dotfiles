{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.network.vnc;
in
{
  options = {
    systems.network.vnc = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables VNC Server and Client 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.wayvnc.enable = true;
    environment.systemPackages = with pkgs; [
      wlvncc
    ];
  };
}
