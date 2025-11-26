{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.development.hdl;
in
{
  options = {
    tools.development.hdl = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables HDL's development tools 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      verilator
      iverilog
      ghdl
      nextpnr
      python312Packages.apycula
      gtkwave # for visualizing tests output
      (yosys.withPlugins (
        with yosys.allPlugins;
        [
          ghdl
        ]
      ))
      openfpgaloader
      netlistsvg # for visualizing rtl yosys files
      quartus-prime-lite
    ];

    programs.nixvim.plugins.lsp.servers = {
      vhdl_ls.enable = true;
      verible.enable = true;
    };
  };
}
