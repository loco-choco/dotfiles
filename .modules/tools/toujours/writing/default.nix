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
      obsidian
    ];
    programs.nvf.settings.vim = {
      lsp.presets.texlab.enable = true;
      languages = {
        typst.enable = true;
        markdown.enable = true;
      };
    };
  };
}
