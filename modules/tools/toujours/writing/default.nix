{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.toujours.document-writing;
in
{
  options = {
    tools.toujours.document-writing = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables document writing tools
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      libreoffice
      typst
    ];
    programs.nixvim.plugins = {
      typst-preview.enable = true;
      typst-vim = {
        enable = true;
        settings = {
          folding = 1;
          conceal_math = 1;
          embedded_languages = [
            "matlab"
          ];
        };
      };
      lsp.servers = {
        ltex_plus = {
          enable = true;
          package = pkgs.ltex-ls-plus;
        };
      };
    };
  };
}
