{
  stdenvNoCC,
  lib,
  src,
  pname,
}:
stdenvNoCC.mkDerivation {
  inherit pname;
  inherit src;
  version = "0.x";
  installPhase = ''
    mkdir -p $out/share/fonts/truetype/
    cp -r $src/*.{ttf,otf} $out/share/fonts/truetype/
  '';
}
