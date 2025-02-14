{ config, pkgs, ... }:
let
in {
  users.groups.plugdev = { };
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
  services.udev.packages = [
    pkgs.openfpgaloader
    /* (pkgs.writeTextFile {
         name = "via_udev";
         text = ''
           ...
         '';

         destination = "/etc/udev/rules.d/99-via.rules";
       })
    */
  ];

}
