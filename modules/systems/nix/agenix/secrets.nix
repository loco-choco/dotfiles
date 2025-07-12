let
  locopc =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIKOXQlqmDdEpTUaeR2qBlOps/b6D4iK2f5F8SBU7mv0";
  locoware =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMW2w63E8Ek6d2uBgsck0/LNbCPWnZNDAmM/EF03sttq";
  systems = [ locopc locoware ];
in { "github-api.age".publicKeys = systems; }
