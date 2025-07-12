{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.toujours.game.minecraft;
in
{
  options = {
    tools.toujours.game.minecraft = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables minecraft 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (prismlauncher.override {
        jdks = [
          jdk8
          jdk17
        ];
      })
    ];
  };
}
