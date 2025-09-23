{ pkgs, self, ... }:
{
  wrappers.ghostty = {
    basePackage = pkgs.ghostty;
    prependFlags = [ "--config-file=${self + /dotfiles/ghostty/config}" ];
  };
}
