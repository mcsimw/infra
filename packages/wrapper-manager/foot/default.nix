{ pkgs, inputs, ... }:
{
  wrappers.foot = {
    basePackage = pkgs.foot;
    flags = [ "--config=${inputs.dotfiles-legacy.outPath}/.config/foot/foot.ini" ];
  };
}
