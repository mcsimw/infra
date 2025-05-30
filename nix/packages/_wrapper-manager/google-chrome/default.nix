{ lib, inputs', ... }:
let
  commonFlags = [
    "--enable-features=${
      lib.concatStringsSep "," [
        "WebUIDarkMode"
        "TouchpadOverscrollHistoryNavigation"
        "WaylandTextInputV3"
      ]
    }"
    "--force-dark-mode"
  ];
in
{
  wrappers.google-chrome = {
    basePackage = inputs'.browser-previews.packages.google-chrome-dev;
    flags = commonFlags;
  };
}
