{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.terminal.nushel;
in
{
  options = {
    tools.terminal.nushel = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables nushel 
        '';
      };
    };
  };

  config = mkIf cfg.enable {

    users.defaultUserShell = pkgs.nushel;

    home-manager.users.locochoco = {
      programs.nushell = {
        enable = true;
        shellAliases = {
          "nix" = "noglob nix"; # so we can use the # char in flakes
          "w3m" = "w3m -o inline_img_protocol=4"; # so we can see images in kitty
          "den" = "ddgr --np --noua -w en.wiktionary.org";
          "dfr" = "ddgr --np --noua -w fr.wiktionary.org";
        };
        environmentVariables = {
          BROWSER = "w3m";
          VISUAL = "nvim"; # default editor
        };
        plugins = with pkgs.nushellPlugins; [
          dbus
          gstat
          highlight
          net
          units
        ];
      };
    };
  };
}
