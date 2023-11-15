{ config, pkgs, ... }: {
  users.users.locochoco = {
    isNormalUser = true;
    description = "Locochoco";
    extraGroups = [ "networkmanager" "wheel" "dialout" "plugdev" ];
  };
}
