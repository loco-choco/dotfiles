{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.terminal.zsh;
in
{
  options = {
    tools.terminal.zsh = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables zsh 
        '';
      };
    };
  };

  config = mkIf cfg.enable {

    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

    home-manager.users.locochoco = {
      programs.zsh = {
        enable = true;
        syntaxHighlighting.enable = true;
        enableVteIntegration = true;
        autocd = true;
        shellAliases = {
          "nix" = "noglob nix"; # so we can use the # char in flakes
          "w3m" = "w3m -o inline_img_protocol=4"; # so we can see images in kitty
        };
        plugins = [
        ];
        prezto = {
          enable = true;
          prompt.theme = "paradox";
          pmodules = [
            "environment"
            "terminal"
            "editor"
            "history"
            "directory"
            "spectrum"
            "utility"
            "git"
            "completion"
            "prompt"
          ];
        };
      };
    };
  };
}
