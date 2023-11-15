{ config, pkgs, ... }: {
  nix.settings.trusted-users = [ "locochoco" ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
