{ config, pkgs, ... }: {
  boot.loader = {
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot/efi";
    timeout = 1;
    grub = {
      enable = true;
      devices = ["nodev"];
      efiSupport = true;
      useOSProber = true;
      default = "saved";
      splashMode = "normal";
    };
  };
}
