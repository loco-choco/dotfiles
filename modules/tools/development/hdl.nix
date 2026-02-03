{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.development.hdl;
  d10-udev-rule = pkgs.callPackage pkgs.stdenv.mkDerivation {
    name = "quartus-pgm-rules";
    src = ./z99_quartus_pgm.rules;
    dontBuild = true;
    dontConfigure = true;
    installPhase = ''
      mkdir -p $out/lib/udev/rules.d
      cp z99_quartus_pgm.rules $out/lib/udev/rules.d
    '';
  } { };
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
