{
  lib,
  appimageTools,
  fetchurl,
}:

let
  version = "3.0.0-RC3";
  pname = "gimp";

  src = fetchurl {
    url = "https://download.gimp.org/gimp/v3.0/linux/GIMP-${version}-x86_64.AppImage";
    hash = "sha256-OD9iXtN6LW0uXCK6rS8+O2xQ081RnrbgkGmQN4O8rHo=";
  };

  appimageContents = appimageTools.extractType1 { inherit pname src; };
in
appimageTools.wrapType2 rec {
  inherit pname version src;

  # Fake info, will change later
  meta = {
    description = "Viewer for electronic invoices";
    homepage = "https://github.com/ZUGFeRD/quba-viewer";
    downloadPage = "https://github.com/ZUGFeRD/quba-viewer/releases";
    license = lib.licenses.asl20;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    maintainers = with lib.maintainers; [ onny ];
    platforms = [ "x86_64-linux" ];
  };
}
