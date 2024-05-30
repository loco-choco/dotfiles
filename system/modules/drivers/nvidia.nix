{ config, pkgs, ... }: {
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.modesetting.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  #hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
}
