{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.development.game.godot;
in
{
  options = {
    tools.development.game.godot = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables godot development tools 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      godot-mono
    ];
    home-manager.users.locochoco = {
      home.file.".local/share/godot/export_templates/".source =
        "${pkgs.godot-mono.export-templates-bin}/4.5.1.stable/share/godot/export_templates/";
    };
  };
}
