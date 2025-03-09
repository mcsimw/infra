{ localFlake, inputs, ... }:
{ ... }:
{
  imports = [
    localFlake.userModules.git
  ];
  lemon.git.users.mcsimw = {
    enable = true;
    config = "${inputs.dotfiles-legacy.outPath}/.config/git/config";
  };
}
