{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.audio.pipewire;
in
{
  options = {
    systems.audio.pipewire = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables pipewire 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      #jack.enable = true;
    };
  };
}
