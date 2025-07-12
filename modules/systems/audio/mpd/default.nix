{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.audio.mpd;
in
{
  options = {
    systems.audio.mpd = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables mpd 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    services.mpd = {
      enable = true;
      musicDirectory = "/home/locochoco/music";
      extraConfig = ''
        audio_output {
          type "pipewire"
          name "Pipewire Output"
        }
      '';
    };
    # MPD Discord RPC
    services.mpd-discord-rpc = {
      enable = true;
      settings = {
        format = {
          details = "Listening to $title";
          state = "Tunes from $album by $artist";
          timestamp = "elapsed";
          large_image = "notes";
          small_image = "notes";
          large_text = "";
          small_text = "";
        };
      };
    };
    home.packages = [ pkgs.mpc-cli ];
    # MPD Notifications
    systemd.user.services.mpd-notification = {
      Unit = {
        Description = "MPD Notifications";
        After = [
          "graphical-session-pre.target"
          "mpd.service"
        ];
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${pkgs.mpd-notification}/bin/mpd-notification";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
    home.file.".config/mpd-notification.conf".source = ./mpd-notification.conf;
  };
}
