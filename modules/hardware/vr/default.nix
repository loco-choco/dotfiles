{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.hardware.vr;
  monado-pkg = pkgs.monado.overrideAttrs {
    src = pkgs.fetchFromGitLab {
      domain = "gitlab.freedesktop.org";
      owner = "thaytan";
      repo = "monado";
      rev = "dev-constellation-controller-tracking";
      sha256 = "sha256-3laJtIBMQnmvse5lYo1I80DOpFjqWKCH8HY3tIDKpgc=";
    };
    patches = [ ];
  };
in
{
  options = {
    hardware.vr = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables VR with Monado
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    services.monado = {
      enable = true;
      defaultRuntime = true;
      package = monado-pkg;
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

    home-manager.users.locochoco = {
      xdg.configFile."openxr/1/active_runtime.json".source =
        "${monado-pkg}/share/openxr/1/openxr_monado.json";
      xdg.configFile."openvr/openvrpaths.vrpath".text = ''
        {
          "config" :
          [
            "${config.home-manager.users.locochoco.xdg.dataHome}/Steam/config"
          ],
          "external_drivers" : null,
          "jsonid" : "vrpathreg",
          "log" :
          [
            "${config.home-manager.users.locochoco.xdg.dataHome}/Steam/logs"
          ],
          "runtime" :
          [
            "${pkgs.opencomposite}/lib/opencomposite"
          ],
          "version" : 1
        }
      '';
    };
  };
}
