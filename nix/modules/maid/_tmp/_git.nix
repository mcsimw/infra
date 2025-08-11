{ localFlake, ... }:
{ pkgs, ... }:
{
  packages = [ pkgs.git ];
  file.xdg_config."git/config".source = localFlake + "/dotfiles/git/config.ini";
}
