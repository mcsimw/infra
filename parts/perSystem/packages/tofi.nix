{ self, ... }:
let
  sources = import (self + /npins);
in
{
  perSystem =
    { pkgs, ... }:
    {
      packages.tofi = pkgs.tofi.overrideAttrs {
        version = sources.tofi.revision;
        src = sources.tofi;
      };
    };
}
