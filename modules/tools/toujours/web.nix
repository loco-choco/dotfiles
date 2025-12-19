{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.toujours.web;
in
{
  options = {
    tools.toujours.web = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables web viewing tools
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.locochoco = {
      programs.firefox = {
        enable = true;
        nativeMessagingHosts = [ pkgs.pipewire-screenaudio ];
      };
    };
    environment.systemPackages = with pkgs; [
      ungoogled-chromium
    ];
  };
}
