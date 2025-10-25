# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ]
  ++ import ../../modules/modules.nix;

  networking.hostName = "locoware";
  system.stateVersion = "24.05";

  tools = {
    science.spice.enable = true;
    development = {
      profiling.perf.enable = true;
      arduino.enable = true;
      c.enable = true;
      csharp.enable = true;
      git.enable = true;
      java.enable = true;
      microprocessors.enable = true;
      zig.enable = true;
      hdl.enable = false;
      rust.enable = true;
      game.unity.enable = true;
      game.godot.enable = false;
    };
    terminal = {
      enable = true;
      zsh.enable = true;
      nvim.enable = true;
      kitty.enable = true;
    };
    toujours = {
      web.enable = true;
      wine.enable = true;
      art.enable = true;
      rss.enable = true;
      social.enable = true;
      obs.enable = true;
      document-writing.enable = true;
      game = {
        steam.enable = true;
        heroic.enable = true;
        minecraft.enable = true;
        mods.enable = true;
      };
    };
  };
  hardware = {
    drawing-tablet.enable = true;
    android.enable = true;
    keyboard.us-int.enable = true;
    vr.enable = false;
    sdr.rtl-sdr.enable = false;
    logical-analyser.enable = true;
    printer = {
      enable = true;
      deskjet.enable = true;
    };
    scanner.enable = true;
  };
  systems = {
    bluetooth.enable = true;
    nix = {
      trust.all = true;
      github-api-path = config.age.secrets.github-api.path;
    };
    audio.mpd.enable = true;
    audio.pipewire.enable = true;
    disk.ntfs.enable = true;
    localization.france.enable = true;
    boot.grub.enable = true;
    boot.efi.mount-point = "/boot";
    boot.plymouth.enable = false;
    power.sleep.disable = true;
    power.management.enable = true;
    kernel.zen.enable = true;
    gpu.nvidia = {
      enable = true;
      open = false;
    };
    gpu.nvidia-prime = {
      enable = true;
      intel-bus = "PCI:0:2:0";
      nvidia-bus = "PCI:1:0:0";
    };
    network.enable = true;
    network.vpn.enable = true;
    services = {
      asterisk.enable = true;
      mail.enable = true;
      ollama.enable = false;
      docker.enable = true;
      gpg.enable = true;
      waydroid.enable = false;

    };
    font.nerd-font.enable = true;
    desktop.hyprland.enable = true;
  };
}
