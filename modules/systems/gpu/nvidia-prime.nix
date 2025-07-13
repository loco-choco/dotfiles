{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.gpu.nvidia-prime;
in
{
  imports = [ ./nvidia.nix ];
  options = {
    systems.gpu.nvidia-prime = {
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

  config = mkIf cfg.enable {
    systems.gpu.nvidia.enable = true;
    hardware.nvidia.prime = {
      sync.enable = true;
      intelBusId = cfg.intel-bus;
      nvidiaBusId = cfg.nvidia-bus;
    };
  };

}
