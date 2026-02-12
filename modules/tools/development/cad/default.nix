{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.development.cad;
in
{
  options = {
    tools.development.cad = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables 3d printing tools 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      openscad
    ];
    programs.nixvim.plugins.lsp.servers = {
      openscad_lsp.enable = true;
    };
  };
}
