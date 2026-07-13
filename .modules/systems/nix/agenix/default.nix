{
  config,
  lib,
  pkgs,
  ...
}:
{
  age.identityPaths = [ "/home/locochoco/.ssh/id_ed25519" ];
  age.secrets.github-api = {
    file = ./github-api.age;
    mode = "0440";
    owner = "locochoco";
    group = "wheel";
  };
  environment.systemPackages = with pkgs; [
    agenix
  ];
}
