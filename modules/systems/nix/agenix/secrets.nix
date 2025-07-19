let
  homepc = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDzPLQIs7/fbV4X8tMJfx2Y6xAFE3UoLBRbpNmyHhbZD";
  locoware = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMW2w63E8Ek6d2uBgsck0/LNbCPWnZNDAmM/EF03sttq";
  systems = [
    homepc
    locoware
  ];
in
{
  "github-api.age".publicKeys = systems;
}
