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
      godotPackages_4_6.godot-mono
    ];

    home-manager.users.locochoco = {
      xdg.dataFile."godot/export_templates".source =
        "${pkgs.godotPackages_4_6.godot-mono.export-templates-bin}/share/godot/export_templates";
    };
  };
}
