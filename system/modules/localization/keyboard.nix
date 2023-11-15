{ config, pkgs, ... }: {
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };
}
