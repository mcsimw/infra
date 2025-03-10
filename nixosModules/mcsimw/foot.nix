{ inputs, ... }:
_: {
  lemon.foot.users.mcsimw = {
    enable = true;
    config = "${inputs.dotfiles-legacy.outPath}/.config/foot/foot.ini";
  };
}
