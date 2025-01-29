{ config, pkgs, ... }: {
  users.users.locochoco = {
    isNormalUser = true;
    description = "Locochoco";
    extraGroups = [ "networkmanager" "wheel" "dialout" "plugdev" ];
  };
  systemd.sleep.extraConfig = ''
    AllowSuspend=no
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';
}
