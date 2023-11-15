{ config, pkgs, ... }: {
  enviroment.localBinInPath = true;
  enviroment.variables.EDITOR = "nvim";
}
