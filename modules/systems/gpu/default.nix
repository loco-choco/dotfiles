{
  config,
  lib,
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
      prime = {
        enable = mkOption {
          default = false;
          type = types.bool;
          description = ''
            Enables nvidia-prime 
          '';
        };
        intel-bus = mkOption {
          type = types.str;
          description = ''
            Intel GPU Bus Id 
          '';
        };
        nvidia-bus = mkOption {
          type = types.str;
          description = ''
            Nvidia GPU Bus Id
          '';
        };
      };
    };
  };

  config = mkMerge [
    {
      assertions = [
        {
          assertion = config.systems.gpu.nvidia.prime.enable && config.systems.gpu.nvidia.enable;
          message = ''
            Nvidia Prime can only be enabled in computers with nvidia drivers.
          '';
        }
      ];
    }
    (mkIf cfg.enable {
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.graphics.enable = true;
      hardware.nvidia.modesetting.enable = true;
      boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
      hardware.nvidia.open = cfg.open;
      hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
    })
    (mkIf (cfg.enable && cfg.prime.enable) {
      hardware.nvidia.prime = {
        sync.enable = true;
        intelBusId = cfg.prime.intel-bus;
        nvidiaBusId = cfg.prime.nvidia-bus;
      };
    })
  ];
}
