{ inputs, ... }:
_:
{
  lemon.git.users.mcsimw = {
    enable = true;
    config = "${inputs.dotfiles-legacy.outPath}/.config/git/config";
  };
}
