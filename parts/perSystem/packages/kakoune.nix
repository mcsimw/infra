{ self, ... }:
let
  sources = import (self + /npins);
in
{
  perSystem =
    { pkgs, ... }:
    {
      packages.kakoune = pkgs.kakoune-unwrapped.overrideAttrs {
        version = sources.kakoune.revision;
        src = sources.kakoune;
        postPatch = ''
          echo "${sources.kakoune.revision}" >.version
        '';
      };
    };
}
