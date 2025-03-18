{
  lib,
  appimageTools,
  fetchurl,
  system,
}:

let
  version = "3.0.0";
  arch =
    if system == "x86_64-linux" then
      "x86_64"
    else if system == "aarch64-linux" then
      "aarch64"
    else
      throw "Unsupported architecture: ${system}";
  pname = "gimp";

  hash =
    if system == "x86_64-linux" then
      "sha256-9S6+SYirgYYVVJ7N/7Jx5uIOnIQSkDXZOqpPtB+lqWo="
    else if system == "aarch64-linux" then
      "sha256-ghHGVcOXIZCfNadPvXpAF6xQiOImT5G7hsqsBWkWMfw="
    else
      throw "Unsupported architecture: ${system}";

  src = fetchurl {
    url = "https://download.gimp.org/gimp/v3.0/linux/GIMP-${version}-${arch}.AppImage";
    inherit hash;
  };
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
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
    ];
  };
}
