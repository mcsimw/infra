{
  lib,
  appimageTools,
  fetchurl,
  system,
}:

let
  version = "3.0.0-RC3";
  arch = if system == "x86_64-linux" then "x86_64" else if system == "aarch64-linux" then "aarch64" else throw "Unsupported architecture: ${system}";
  pname = "gimp";

  hash = if system == "x86_64-linux" then "sha256-OD9iXtN6LW0uXCK6rS8+O2xQ081RnrbgkGmQN4O8rHo="
         else if system == "aarch64-linux" then "sha256-MM14Xrf17dBEHmQiH9uR6cQTtnzfrwhtgMXt1fQavIk="
         else throw "Unsupported architecture: ${system}";

  src = fetchurl {
    url = "https://download.gimp.org/gimp/v3.0/linux/GIMP-${version}-${arch}.AppImage";
    hash = hash;
  };

  appimageContents = appimageTools.extractType1 { inherit pname src; };
in
appimageTools.wrapType2 rec {
  inherit pname version src;

  meta = {
    description = "GNU Image Manipulation Program";
    homepage = "https://www.gimp.org/";
    downloadPage = "https://download.gimp.org/gimp/v3.0/linux/";
    license = lib.licenses.gpl3Plus;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    maintainers = with lib.maintainers; [ ]; # Add maintainers if needed
    platforms = [ "x86_64-linux" "aarch64-linux" ];
  };
}

