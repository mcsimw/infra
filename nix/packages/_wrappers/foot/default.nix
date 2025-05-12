{ pkgs, self, ... }:
{
  wrappers.foot = {
    basePackage = pkgs.foot;
    flags = [ "--config=${self + /foot/foot.ini}" ];
  };
}
