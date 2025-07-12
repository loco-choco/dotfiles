{
  config,
  lib,
  pkgs,
  ...
}:
{
  users.users.locochoco = {
    isNormalUser = true;
    description = "Locochoco";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      "plugdev"
    ];
  };

  home.username = "locochoco";
  home.homeDirectory = "/home/locochoco";

  programs.home-manager.enable = true;
  home.stateVersion = "23.05";
}
