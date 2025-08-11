{ self, ... }:
{ pkgs, ... }:
{
  packages = [ pkgs.mpv ];
  file.xdg_config."mpv/mpv.conf".source = self + "/dotfiles/mpv/mpv.conf";
}
