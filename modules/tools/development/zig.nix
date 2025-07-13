{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.development.zig;
in
{
  options = {
    tools.development.zig = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables zig development tools 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      zig
    ];

    programs.nixvim.plugins.zig.enable = true;
    programs.nixvim.plugins.lsp.servers.zls.enable = true;
  };
}
