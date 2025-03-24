{ config, pkgs, ... }:
{
  services.monado = {
    enable = true;
    defaultRuntime = true;
    package = pkgs.monado.overrideAttrs {
      src = pkgs.fetchFromGitLab {
        domain = "gitlab.freedesktop.org";
        owner = "thaytan";
        repo = "monado";
        rev = "dev-constellation-controller-tracking";
        sha256 = "sha256-He/RI6cwfC70k0fh/w4ou9rppSOKak2hAzut56x0j3Y=";
      };
      patches = [ ];
    };
  };
  environment.sessionVariables = {
    VIT_SYSTEM_LIBRARY_PATH = "${pkgs.basalt-monado}/lib/libbasalt.so";
  };
  systemd.user.services.monado.environment = {
    STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
    WMR_HANDTRACKING = "0";
  };
  environment.systemPackages = with pkgs; [
    wlx-overlay-s
    opencomposite
  ];
}
