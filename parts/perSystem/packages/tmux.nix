{ self, ... }:
let
  sources = import (self + /npins);
in
{
  perSystem =
    { pkgs, ... }:
    {
      packages.tmux = pkgs.tmux.overrideAttrs {
        version = sources.tmux.revision;
        src = sources.tmux;
      };
    };
}
