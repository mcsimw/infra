{
  stdenvNoCC,
  fetchzip,
}:

stdenvNoCC.mkDerivation rec {
  pname = "Lucidia";
  version = "1.0";

  src = fetchzip {
    url = "https://font.download/dl/font/lucida-sans.zip";
    stripRoot = false;
    hash = "sha256-hzNOWIA15XLAe1WfMtBX1BIkW4OYn1fuj3mbKx/Jnww=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/truetype
    cp ./*.{ttf,TTF} $out/share/fonts/truetype

    runHook postInstall
  '';

}
