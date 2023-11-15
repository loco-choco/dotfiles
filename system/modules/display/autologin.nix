{ config, pkgs, ... }: {
  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = "locochoco";
  };
}
