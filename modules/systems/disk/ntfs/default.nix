{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.disk.ntfs;
in
{
  options = {
    systems.disk.ntfs = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables compat with NTFS file system
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    boot.supportedFilesystems = [ "ntfs" ];
    environment.systemPackages = [
      pkgs.ntfs3g
    ];
  };
}
