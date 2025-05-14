{ pkgs, self, ... }:
{
  wrappers.nyxt = {
    basePackage = pkgs.nyxt;
    flags = [ "--init=${self + /nyxt/config.lisp}" ];
  };
}
