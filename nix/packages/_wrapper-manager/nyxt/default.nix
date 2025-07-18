{ pkgs, self, ... }:
{
  wrappers.nyxt = {
    basePackage = pkgs.nyxt;
    prependFlags = [ "--init=${self + dotfiles/nyxt/config.lisp}" ];
  };
}
