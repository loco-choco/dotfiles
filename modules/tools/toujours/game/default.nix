{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.toujours.game;
in
{
  options = {
    tools.toujours.game = {
      heroic.enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables heroic
        '';
      };
      minecraft.enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables minecraft 
        '';
      };
      mods.enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables mod managers
        '';
      };
      steam.enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables steam 
        '';
      };
      retro.enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables retroarch 
        '';
      };
    };
  };

  config = mkMerge [
    (mkIf cfg.heroic.enable {
      environment.systemPackages = with pkgs; [
        heroic
      ];
    })
    (mkIf cfg.minecraft.enable {
      environment.systemPackages = with pkgs; [
        (prismlauncher.override {
          jdks = [
            jdk8
            jdk17
          ];
        })
      ];
    })
    (mkIf cfg.mods.enable {
      environment.systemPackages = with pkgs; [
        owmods-cli
        r2modman
        everest-mons
        archipelago
      ];
    })
    (mkIf cfg.steam.enable {
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
      };
    })
    (mkIf cfg.retro.enable {
      environment.systemPackages = with pkgs; [
        (retroarch.withCores (
          cores: with cores; [
            melonds
          ]
        ))
      ];
    })
  ];
}
