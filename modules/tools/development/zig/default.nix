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

    programs.nvf.settings.vim.languages.zig.enable = true;
  };
}
