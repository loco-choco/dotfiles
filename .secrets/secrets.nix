let
  locopc =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIKOXQlqmDdEpTUaeR2qBlOps/b6D4iK2f5F8SBU7mv0";
  systems = [ locopc ];
in { "github-api.age".publicKeys = systems; }
