{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.terminal.nushell;
in
{
  options = {
    tools.terminal.nushell = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables nushell 
        '';
      };
    };
  };

  config = mkIf cfg.enable {

    users.defaultUserShell = pkgs.nushell;

    home-manager.users.locochoco = {
      programs.nushell = {
        enable = true;
        package = pkgs.nushell;
        shellAliases = {
          "nix" = "noglob nix"; # so we can use the # char in flakes
          "w3m" = "w3m -o inline_img_protocol=4"; # so we can see images in kitty
          "den" = "ddgr --np --noua -w en.wiktionary.org";
          "dfr" = "ddgr --np --noua -w fr.wiktionary.org";
        };
        configFile.source = ./config.nu;
        environmentVariables = {
          BROWSER = "w3m";
          VISUAL = "nvim"; # default editor
        };
      };
      programs.carapace = {
        enable = true;
        enableNushellIntegration = true;
      };
      programs.starship = {
        enable = true;
        enableNushellIntegration = true;
        presets = [ "gruvbox-rainbow" ];
        extraPackages = [ pkgs.starship-jj ];
        settings = {

          format = lib.concatStrings [
            "[](color_orange)"
            "$os"
            "$username"
            "[](bg:color_yellow fg:color_orange)"
            "$directory"
            "[](fg:color_yellow bg:color_aqua)"
            "$git_branch"
            "$git_status"
            "$\{custom.jj}"
            "[](fg:color_aqua bg:color_blue)"
            "$c"
            "$cpp"
            "$rust"
            "$golang"
            "$nodejs"
            "$bun"
            "$php"
            "$java"
            "$kotlin"
            "$haskell"
            "$python"
            "[](fg:color_blue bg:color_bg3)"
            "$docker_context"
            "$conda"
            "$pixi"
            "[](fg:color_bg3 bg:color_bg1)"
            "$time"
            "[ ](fg:color_bg1)"
            "$line_break"
            "$character"
          ];

          custom.jj = {
            command = "prompt";
            format = "$output";
            ignore_timeout = true;
            shell = [
              "starship-jj"
              "--ignore-working-copy"
              "starship"
            ];
            use_stdin = false;
            when = true;
          };

        };
      };
    };
  };
}
