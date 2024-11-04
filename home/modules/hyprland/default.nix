{ pkgs, config, ... }: {
  imports = [ ./mpd ];
  home.packages = with pkgs; [ swww grimblast ];
  services.dunst = {
    enable = true;
    settings = import ./dunst;
  };
  programs.waybar = {
    enable = true;
    settings = import ./waybar;
    style = ./waybar/style.css;
  };
  programs.rofi = {
    enable = true;
    terminal = "\${pkgs.kitty}/bin/kitty";
    font = "FiraCode Nerd Font Mono 15";
    theme = ./rofi/theme.rasi;
  };
  home.file = {
    ".local/share/icons/" = {
      source = ./cursor;
      recursive = true;
    };
  };
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    input = {
      kb_layout = "us";
      kb_variant = "intl";
    };
    exec-once = [ "waybar" "swww init" ];
    exec = [
      "swww img ~/.dotfiles/home/modules/hyprland/wallpaper/rw-region-1.png"
    ];
    "general:gaps_out" = "2";
    "general:gaps_in" = "2";
    "decoration:rounding" = "2";
    monitor = [ "HDMI-A-1,highrr,auto,1,mirror,eDP-1" "eDP-1,highrr,auto,1" ];
    "xwayland:force_zero_scaling" = "true";
    cursor = { no_hardware_cursors = true; };
    env = [
      "GDK_SCALE,1"
      "XCURSOR_SIZE,16"
      "LIBVA_DRIVER_NAME,nvidia"
      "XDG_SESSION_TYPE,wayland"
      "GBM_BACKEND,nvidia-drm"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      "HYPRCURSOR_THEME,Bibata-Modern-Ice"
      "HYPRCURSOR_SIZE,24"
      "XCURSOR_THEME,Bibata-Modern-Ice"
      "XCURSOR_SIZE,32"
    ];
    bindr = [ "SUPER, SUPER_L, exec, pkill waybar || waybar" ];
    binde = [
      ", XF86AudioRaiseVolume, exec, sh ~/.dotfiles/home/modules/hyprland/scripts/pips-volume-selector.sh raise"
      ", XF86AudioLowerVolume, exec, sh ~/.dotfiles/home/modules/hyprland/scripts/pips-volume-selector.sh lower"
      ", XF86AudioMute, exec, sh ~/.dotfiles/home/modules/hyprland/scripts/pips-volume-selector.sh mute"
    ];
    bindm = [ "$mod, mouse:272, movewindow" "$mod, mouse:273, resizewindow" ];
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
    ] ++ (
      # workspaces
      # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
      builtins.concatLists (builtins.genList (x:
        let ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
        in [
          "$mod, ${ws}, workspace, ${toString (x + 1)}"
          "$mod, ${ws}, exec, swww img ~/.dotfiles/home/modules/hyprland/wallpaper/rw-region-${
            toString (x + 1)
          }.png --transition-type right --transition-duration 0 --transition-step 255"
          "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
          "$mod SHIFT, ${ws}, exec, swww img ~/.dotfiles/home/modules/hyprland/wallpaper/rw-region-${
            toString (x + 1)
          }.png --transition-type right --transition-duration 0 --transition-step 255"
        ]) 10));
  };
}
