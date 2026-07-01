{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.development.rust;
in
{
  options = {
    tools.development.rust = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables Rust development tools 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      rustup
    ];

    programs.nixvim.plugins.lsp.servers.rust_analyzer = {
      enable = true;
      installRustc = false;
      installCargo = false;
    };
  };
}
