{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.toujours.rss;
in
{
  options = {
    tools.toujours.rss = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables rss viewing tools
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.newsboat = {
      enable = true;
      autoReload = true;
      urls = [
        { url = "https://xeiaso.net/blog.rss"; }
        { url = "https://www.tamberlanecomic.com/feed.xml"; }
        { url = "https://weekly.nixos.org/feeds/all.rss.xml"; }
        { url = "https://rainworldanthroau.thecomicseries.com/rss/"; }
        { url = "https://outerwildsmods.com/feed.xml"; }
      ];
    };
  };
}
