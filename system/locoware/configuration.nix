# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../modules/drivers/nvidia.nix
    # Machine configs
    ../modules/grub.nix

    ../modules/user.nix

    ../modules/networking.nix
    ../modules/pipewire.nix
    ../modules/cups.nix
    ../modules/environment.nix
    ../modules/fonts.nix
    ../modules/nix
    ../modules/display/hyprland

    ../modules/localization/locale.nix
    ../modules/udev.nix

    # Apps and others
    #../modules/rtl-sdr.nix
    #../modules/drawingtablet.nix
    ../modules/steam.nix
    ../modules/development.nix
    ../modules/zsh.nix
    ../modules/common-programs.nix
  ];

  services.tlp = {
    enable = true;
    settings = {
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      PLATFORM_PROFILE_ON_AC = "balanced";
      PLATFORM_PROFILE_ON_BAT = "low-power";
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;
    };
  };

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "eurosign:e,caps:escape";
  # Until fix, we go closed
  hardware.nvidia.open = pkgs.lib.mkForce false;
  # Dual GPU Setup
  hardware.nvidia.prime = {
    sync.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };
  system.stateVersion = "24.05";
}
