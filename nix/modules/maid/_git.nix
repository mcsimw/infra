{ self, ... }:
{ pkgs, ... }:
{
  packages = [ pkgs.git ];
  file.xdg_config."git/config".source = self + "/dotfiles/git/config.ini";
}
