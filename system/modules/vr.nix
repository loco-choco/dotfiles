{ config, pkgs, ... }:
{
  # hardware.opentabletdriver.enable = true;
  services.monado = {
    enable = true;
    defaultRuntime = true;
  };
  systemd.user.services.monado.environment = {
    STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
  };
  environment.systemPackages = with pkgs; [
    wlx-overlay-s
    opencomposite
  ];
}
