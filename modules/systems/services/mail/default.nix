{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.services.mail;
in
{
  options = {
    systems.services.mail = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables mail services 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    programs.thunderbird.enable = true;
    services.protonmail-bridge.enable = true;
    services.passSecretService.enable = true;
  };
}
