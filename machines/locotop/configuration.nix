# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ../../modules/modules.nix
    ./hardware-configuration.nix
  ];
  networking.hostName = "locotop"; # Define your hostname.
  system.stateVersion = "23.05"; # Did you read the comment?

  tools = {
    science.spice.enable = true;
    development = {
      profiling.perf.enable = true;
      arduino.enable = true;
      git.enable = true;
      microprocessors.enable = true;
      zig.enable = true;
      hdl.enable = true;
      csharp.enable = true;
      rust.enable = true;
      game.unity.enable = false;
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
      game.steam.enable = true;
    };
  };
  hardware = {
    drawing-tablet.enable = true;
    android.enable = true;
    keyboard.br-abnt2.enable = true;
    sdr.rtl-sdr.enable = false;
    logical-analyser.enable = true;
    printer = {
      enable = true;
    };
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
    localization.brazil.enable = true;
    boot.grub.enable = true;
    boot.efi.mount-point = "/boot";
    power.sleep.disable = true;
    power.management.enable = true;
    kernel.zen.enable = true;

    network.enable = true;
    network.vpn.enable = true;
    services = {
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
