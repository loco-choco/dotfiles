{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.boot.grub;
in
{
  options = {
    systems.boot.grub = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables GRUB 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      timeout = 1;
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
        default = "saved";
        splashMode = "normal";
        theme = pkgs.stdenv.mkDerivation {
          pname = "minegrub-world-sel-theme";
          version = "git";
          src = pkgs.fetchFromGitHub {
            owner = "Lxtharia";
            repo = "minegrub-world-sel-theme";
            rev = "2d9637455b41faf6bc0b966d9417cf85d79ff3aa";
            sha256 = "sha256-zjvuWo3iod1E6ya0q0XYX+3QMF36hR7ZD1nwFkiPgg0=";
          };
          installPhase = "cp -r minegrub-world-selection $out";
        };
      };
    };
  };
}
