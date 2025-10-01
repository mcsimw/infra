{ pkgs, self, ... }:
{
  wrappers.mpv = {
    basePackage = pkgs.mpv;
    prependFlags = [
      "--no-config"
      "--config-dir=${self + dotfiles/mpv/mpv.config}"
    ];
  };
}
