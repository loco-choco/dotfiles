{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.development.hdl;
  d10-udev-rule = pkgs.writeTextFile {
    name = "quartus-pgm-rules";
    text = builtins.readFile ./z99_quartus_pgm.rules;
    destination = "/lib/udev/rules.d/z99_quartus_pgm.rules";
  };
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
    services.udev.packages = [ d10-udev-rule ];
    programs.nixvim.plugins.lsp.servers = {
      vhdl_ls.enable = true;
      verible.enable = true;
    };
  };
}
