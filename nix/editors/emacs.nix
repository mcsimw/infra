{ config, ... }:
{
  nixpkgs.overlays = [ (import config.sources.emacs-overlay) ];
}
