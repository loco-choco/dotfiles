{
  lib,
  stdenv,
  fetchFromCodeberg,
  meson,
  ninja,
  udevCheckHook,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "game-devices-udev-rules";
  version = "1.0";

  src = fetchFromCodeberg {
    owner = "fabiscafe";
    repo = "game-devices-udev";
    tag = finalAttrs.version;
    hash = "sha256-J4LfRifTqBM+B/dryLHERaVa1UUWEbfjEUj+exCFVsU=";
  };

  nativeBuildInputs = [
    udevCheckHook
    meson
    ninja
  ];

  doInstallCheck = true;
})
