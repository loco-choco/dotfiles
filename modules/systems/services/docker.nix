{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.systems.services.docker;
in
{
  options = {
    systems.services.docker = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables docker 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    virtualisation.docker = {
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
      daemon.settings = {
        #experimental = true;
        default-address-pools = [
          {
            base = "172.30.0.0/16";
            size = 24;
          }
        ];
      };
    };
    users.extraGroups.docker.members = builtins.attrNames config.users.users;
  };
}
