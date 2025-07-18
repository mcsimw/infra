{ pkgs, self, ... }:
{
  wrappers.nyxt = {
    basePackage = pkgs.nyxt;
    prependFlags = [ "--init=${self + /nyxt/config.lisp}" ];
  };
}
