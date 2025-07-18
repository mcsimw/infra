{ pkgs, self, ... }:
{
  wrappers.foot = {
    basePackage = pkgs.foot;
    prependFlags = [ "--config=${self + /foot/foot.ini}" ];
  };
}
