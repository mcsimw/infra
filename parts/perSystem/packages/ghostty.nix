{ self, ... }:
let
  sources = import (self + /npins);
in
{
  perSystem =
    { system, ... }:
    {
      packages.ghostty = (import sources.ghostty).packages.${system}.default;
    };
}
