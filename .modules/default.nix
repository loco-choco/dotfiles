{
  lib,
  ...
}:

{
  imports = lib.remove ./default.nix (
    lib.filter (path: lib.strings.hasSuffix "default.nix" path) (lib.filesystem.listFilesRecursive ./.)
  );
}
