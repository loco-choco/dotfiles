{ config, pkgs, ... }: {
  nix.settings.trusted-users = [ "locochoco" ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.extraOptions = ''
    !include ${config.age.secrets.github-api.path}
  '';
  environment.systemPackages = with pkgs; [ cached-nix-shell ];

}
