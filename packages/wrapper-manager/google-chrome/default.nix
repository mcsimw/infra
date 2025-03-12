{
  lib,
  inputs',
  ...
}:
{
  wrappers.google-chrome = {
    basePackage = inputs'.browser-previews.packages.google-chrome-dev;
    flags = [
      "--enable-features=${
        lib.concatStringsSep "," [
          "WebUIDarkMode"
          "TouchpadOverscrollHistoryNavigation"
        ]
      }"
      "--force-dark-mode"
    ];
  };
}
