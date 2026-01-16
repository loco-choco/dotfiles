{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.desktop.hyprland;
in
{
  imports = [
    ../rofi/default.nix
    ../dunst/default.nix
    ../waybar/default.nix
  ];

  options = {
    systems.desktop.hyprland = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables hyprland 
        '';
      };
    };
  };

  config = mkIf cfg.enable {

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
    programs.hyprland.enable = true;

    services.greetd = {
      enable = true;
      useTextGreeter = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd start-hyprland --greeting 'Welcome aboard captain!' --remember";
          user = "greeter";
        };
      };
    };

    systems.desktop = {
      dunst.enable = true;
      waybar.enable = true;
      rofi.enable = true;
    };

    home-manager.users.locochoco = {
      home.packages = with pkgs; [
        swww
        grimblast
      ];

      home.pointerCursor = {
        enable = true;
        hyprcursor.enable = true;
        hyprcursor.size = 32;
        package = pkgs.graphite-cursors;
        name = "graphite-dark-nord";
      };

      wayland.windowManager.hyprland.enable = true;
      wayland.windowManager.hyprland.settings = {
        "$mod" = "SUPER";
        input = {
          kb_layout = "us";
          kb_variant = "intl";
        };
        exec-once = [
          "waybar"
          "swww-daemon"
        ];
        exec = [
          "swww img ${../wallpapers/rw-region-1.png}"
        ];
        "general:gaps_out" = "2";
        "general:gaps_in" = "2";
        "decoration:rounding" = "2";
        monitor = [
          ",highrr,auto,1,mirror,DP-2"
          "DP-2,highrr,auto,1"
        ];
        "xwayland:force_zero_scaling" = "true";
        cursor = {
          no_hardware_cursors = true;
        };
        env = [
          "GDK_SCALE,1"
          "XCURSOR_SIZE,16"
          "LIBVA_DRIVER_NAME,nvidia"
          "XDG_SESSION_TYPE,wayland"
          "GBM_BACKEND,nvidia-drm"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
        ];
        bindr = [ "SUPER, SUPER_L, exec, pkill waybar || waybar" ];
        binde = [
          ", XF86AudioRaiseVolume, exec, sh ${./scripts/pips-volume-selector.sh} raise"
          ", XF86AudioLowerVolume, exec, sh ${./scripts/pips-volume-selector.sh} lower"
          ", XF86AudioMute, exec, sh ${./scripts/pips-volume-selector.sh} mute"
        ];
        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];
        bind = [
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"
          "$mod, C, killactive,"
          "$mod, V, togglefloating,"
          "$mod, F, exec, firefox"
          "$mod, K, exec, kitty"
          "$mod, Space, exec, rofi -show combi -modes combi -combi-modes 'window,drun,run'"
          ", Print, exec, grimblast copy output"
          "$mod, P, exec, grimblast copy output"
          "$mod ALT, P, exec, grimblast copy area"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (
            builtins.genList (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod, ${ws}, exec, swww img ${../wallpapers}/rw-region-${toString (x + 1)}.png --transition-type right --transition-duration 0 --transition-step 255"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, exec, swww img ${../wallpapers}/rw-region-${toString (x + 1)}.png --transition-type right --transition-duration 0 --transition-step 255"
              ]
            ) 10
          )
        );
      };

    };
  };
}
