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
    programs.nixvim.plugins.lsp.servers = {
      ltex_plus = {
        enable = true;
        package = pkgs.ltex-ls-plus;
      };
    };
  };
}
