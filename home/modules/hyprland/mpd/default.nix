{ pkgs, config, ... }: {
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
}
