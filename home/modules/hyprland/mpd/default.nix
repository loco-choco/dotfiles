{ pkgs, config, ... }: {
  services.mpd = {
    enable = true;
    musicDirectory = "/path/to/music";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "Pipewire Output"
      }
    '';
  };
  services.mpd-discord-rpc.enable = true;
}
