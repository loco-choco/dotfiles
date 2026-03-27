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

  config = mkMerge [
    (mkIf cfg.enable {
      programs.wayvnc.enable = true;
      environment.systemPackages = with pkgs; [
        wlvncc
      ];
    })
    (mkIf cfg.enable config.systems.desktop.plasma6.enable {
      environment.systemPackages = with pkgs.kdePackages; [
        krdc
        krfb
      ];
    })

  ];
}
