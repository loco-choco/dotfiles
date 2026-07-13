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
    virtualisation.oci-containers.backend = "podman";
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };
    environment.systemPackages = [
      pkgs.distrobox
      pkgs.podman-tui
    ];
    users.extraGroups.docker.members = builtins.attrNames config.users.users;
  };
}
