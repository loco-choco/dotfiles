{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.development.microprocessors;
in
{
  options = {
    tools.development.microprocessors = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables microprocessors development tools 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      gnumake
      sdcc
      gputils
      gcc-arm-embedded
      gdb
      segger-jlink
    ];
    services.udev.packages = [ pkgs.segger-jlink ];
    programs.nixvim.plugins.lsp.servers = {
      asm_lsp.enable = true;
    };
  };
}
