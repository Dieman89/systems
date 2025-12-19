{ pkgs }:

pkgs.stdenvNoCC.mkDerivation {
  pname = "custom-fonts";
  version = "1.0";

  src = ../assets/fonts.zip;

  nativeBuildInputs = [ pkgs.unzip ];

  unpackPhase = ''
    unzip $src
  '';

  installPhase = ''
    mkdir -p $out/share/fonts/truetype $out/share/fonts/opentype
    find . -name "*.ttf" -exec install -Dm644 {} $out/share/fonts/truetype/ \;
    find . -name "*.otf" -exec install -Dm644 {} $out/share/fonts/opentype/ \;
  '';

  meta = {
    description = "Custom fonts collection";
    license = pkgs.lib.licenses.unfree;
  };
}
