{ pkgs, self, ... }:
{
  wrappers.mpv = {
    basePackage = pkgs.mpv;
    flags = [
      "--no-config"
      "--config-dir=${self + /mpv/mpv.config}"
    ];
  };
}
