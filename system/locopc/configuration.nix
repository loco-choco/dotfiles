{ config, pkgs, ... }:
{
  imports = [
    # Hardware.
    ./hardware-configuration.nix
    ../modules/drivers/nvidia.nix
    # Machine configs
    ../modules/grub.nix

    ../modules/user.nix
    #../modules/display/kde
    ../modules/display/hyprland
    #../modules/display/autologin.nix

    ../modules/networking.nix
    ../modules/pipewire.nix
    ../modules/cups.nix
    ../modules/environment.nix
    ../modules/fonts.nix
    ../modules/nix

    ../modules/localization/locale.nix
    ../modules/localization/keyboard.nix

    # Apps and others
    ../modules/rtl-sdr.nix
    ../modules/drawingtablet.nix
    ../modules/steam.nix
    ../modules/development.nix
    ../modules/zsh.nix
    ../modules/common-programs.nix
    ../modules/vr.nix
  ];

  boot.supportedFilesystems = [ "ntfs" ];

  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  networking.hostName = "locopc";

  system.stateVersion = "22.11";
}
