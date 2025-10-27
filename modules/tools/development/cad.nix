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
      (openscad.overrideAttrs (prev: {
        version = "master";
        src = pkgs.fetchFromGitHub {
          owner = "openscad";
          repo = "openscad";
          rev = "450ec6abc7f463715d10e65a20e1d0e17122f445";
          sha256 = "sha256-uaIeeCvizrEayl60ntAdMsBi6NZEUoRPADoeDlIqI+4=";
        };
      }))
    ];
    programs.nixvim.plugins.lsp.servers = {
      openscad_lsp.enable = true;
    };
  };
}
