{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.tools.science.math;
  matlab-docker-options = "--user locochoco:locochoco -it --name matlab -v /home/locochoco:/home/matlab/Desktop/Host --userns=keep-id --init --rm -p 5901:5901 -p 6080:6080 --shm-size=512M";
  matlab-docker = pkgs.dockerTools.pullImage {
    imageName = "mathworks/matlab";
    imageDigest = "sha256:5c160ad975b81683aef17fe87a98cab7b8e5ce2029fc290ad48a66edf7ae0eec";
    finalImageName = "matlab";
    finalImageTag = "r2024a";
    hash = "sha256-857xzjkkBcJ42dvV7OO9lRZNx26NLpg2v9nBsMK3sAs=";
  };
in
{
  options = {
    tools.science.math = {
      enable = mkOption {
        default = false;
        type = types.bool;
        description = ''
          Enables math related tools 
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      numbat
      (octaveFull.withPackages (p: [
        p.signal
        p.communications
        p.miscellaneous
      ]))
      (pkgs.writeShellScriptBin "matlab" ''
        echo ${matlab-docker}
        podman run ${matlab-docker-options} docker-archive:${matlab-docker} -vnc
      '')
    ];
    #virtualisation.oci-containers.containers = {
    #  matlab = {
    #    image = "matlab";
    #    imageFile = matlab-docker;
    #    devices = [
    #      "/dev/ttyACM0:/dev/ttyACM0"
    #    ];
    #  };
    #};
  };
}
