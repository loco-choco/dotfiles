{ config, pkgs, ... }: {
  services.xserver = {
    enable = true;
    autorun = false;
    exportConfiguration = true;
    displayManager.startx.enable = true;
  };
  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland --greeting 'Welcome aboard captain!' --remember"; 
        user = "greeter";
      };
    };
  };
}
