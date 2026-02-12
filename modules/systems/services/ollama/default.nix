{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.services.ollama;
in
{
  options = {
    systems.services.ollama = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables ollama 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    services.ollama.enable = true;
    services.open-webui.enable = true;
  };
}
