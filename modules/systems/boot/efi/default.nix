{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.boot.efi;
in
{
  options = {
    systems.boot.efi = {
      mount-point = mkOption {
        default = "/boot";
        type = types.str;
        description = ''
          EFI mount path
        '';
      };
    };
  };

  config = {
    boot.loader.efi.efiSysMountPoint = cfg.mount-point;
  };
}
