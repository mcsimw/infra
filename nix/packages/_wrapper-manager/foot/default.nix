{ pkgs, self, ... }:
{
  wrappers.foot = {
    basePackage = pkgs.foot;
    prependFlags = [ "--config=${self + /stow/foot/.config/foot/foot.ini}" ];
  };
}
