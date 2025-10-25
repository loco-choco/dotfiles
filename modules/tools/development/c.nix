{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.development.c;
in
{
  options = {
    tools.development.c = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables C development tools 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gnumake
      gdb
      libgcc
    ];
    programs.nixvim.plugins.lsp.servers = {
      ccls.enable = true;
    };
  };
}
