{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.services.gpg;
in
{
  options = {
    systems.services.gpg = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables gpg related services 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    home-manager.users.locochoco = {
      programs.gpg = {
        enable = true;
      };

      services.gpg-agent = {
        enable = true;
        pinentry.package = pkgs.pinentry-qt;
      };
    };
  };
}
