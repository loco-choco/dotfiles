{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.gpu.nvidia;
in
{
  options = {
    systems.gpu.nvidia = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables nvidia drivers 
        '';
      };
      open = mkOption {
        default = true;
        type = types.bool;
        description = ''
          Makes it use the open drivers 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.graphics.enable = true;
    hardware.nvidia.modesetting.enable = true;
    boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
    hardware.nvidia.open = cfg.open;
    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;
  };
}
