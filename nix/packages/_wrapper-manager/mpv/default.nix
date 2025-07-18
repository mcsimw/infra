{ pkgs, self, ... }:
{
  wrappers.mpv = {
    basePackage = pkgs.mpv;
    prependFlags = [
      "--no-config"
      "--config-dir=${self + /mpv/mpv.config}"
    ];
  };
}
