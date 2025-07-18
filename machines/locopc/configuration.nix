{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ] ++ import ../../modules/modules.nix;

  networking.hostName = "locopc";
  system.stateVersion = "22.11";

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
      game = {
        steam.enable = true;
        heroic.enable = true;
        minecraft.enable = true;
      };
    };
  };
  hardware = {
    drawing-tablet.enable = true;
    android.enable = true;
    keyboard.br-abnt2.enable = true;
    vr.enable = false;
    sdr.rtl-sdr.enable = false;
    logical-analyser.enable = false;
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
    localization.brazil.enable = true;
    boot.grub.enable = true;
    boot.efi.mount-point = "/boot/efi";
    boot.plymouth.enable = false;
    power.sleep.disable = true;
    kernel.zen.enable = true;
    gpu.nvidia = {
      enable = true;
      open = false;
    };
    network.enable = true;
    network.vpn.enable = false;
    services = {
      mail.enable = true;
      ollama.enable = false;
      docker.enable = false;
      gpg.enable = true;
      waydroid.enable = false;

    };
    font.nerd-font.enable = true;
    desktop.plasma6.enable = true;
  };
}
