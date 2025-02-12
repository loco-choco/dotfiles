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
    (pkgs.writeTextFile {
      name = "via-bot";
      text = ''
        # Rules to filter and symlink the robot usb sensors and other devices
        # Right Motor
        KERNEL=="ttyUSB[0-9]*", SUBSYSTEM=="tty", KERNELS=="1-[1-9]*.1", SUBSYSTEMS=="usb", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="7523", SYMLINK+="right-motor"
        # Left Motor
        KERNEL=="ttyUSB[0-9]*", SUBSYSTEM=="tty", KERNELS=="1-[1-9]*.4", SUBSYSTEMS=="usb", ATTRS{idVendor}=="1a86", ATTRS{idProduct}=="7523", SYMLINK+="left-motor"
        # UBLOX
        KERNEL=="ttyACM[0-9]*", SUBSYSTEM=="tty", SUBSYSTEMS=="usb", ATTRS{idVendor}=="1546", ATTRS{idProduct}=="01a8", SYMLINK+="ublox-gps"
        # Cube 
        #KERNEL=="ttyACM[0-9]*", SUBSYSTEM=="tty", SUBSYSTEMS=="usb", ATTRS{idVendor}=="", ATTRS{idProduct}=="", SYMLINK+="cube-orange"
      '';

      destination = "/etc/udev/rules.d/99-via-bot.rules";
    })
  ];

}
