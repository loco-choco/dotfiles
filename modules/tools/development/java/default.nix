{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.development.java;
in
{
  options = {
    tools.development.java = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables Java development tools 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gnumake
      gdb
      jdk25
    ];
    programs.nixvim.plugins.lsp.servers = {
      java_language_server.enable = true;
    };
  };
}
