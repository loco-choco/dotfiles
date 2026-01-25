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
      home.file.".local/share/godot/export_templates/${
        builtins.replaceStrings [ "-" ] [ "." ] pkgs.godot-mono.export-templates-bin.version
      }".source =
        pkgs.godot-mono.export-templates-bin;
    };
  };
}
