{ config, pkgs, ... }:
{
  environment.localBinInPath = true;
  environment.variables.EDITOR = "nvim";
}
