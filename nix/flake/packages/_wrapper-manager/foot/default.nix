{ pkgs, self, ... }:
{
  wrappers.foot = {
    basePackage = pkgs.foot;
    prependFlags = [ "--config=${self + /stow/linux/foot/.config/foot/foot.ini}" ];
  };
}
