{ pkgs, self, ... }:
{
  wrappers.foot = {
    basePackage = pkgs.foot;
    prependFlags = [ "--config=${self + /dotfiles/foot/foot.ini}" ];
  };
}
