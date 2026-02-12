{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.toujours.music-production;
in
{
  options = {
    tools.toujours.music-production = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables music production tools
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    musnix.enable = true;
    users.users.locochoco.extraGroups = [ "audio" ];

    environment.systemPackages = with pkgs; [
      audacity
      lmms
      polyphone
      vital
      infamousPlugins
      lsp-plugins
      yabridge
      yabridgectl
    ];
  };
}
