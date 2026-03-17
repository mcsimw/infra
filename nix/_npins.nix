# Bad idea™: Bootstrap npins from its own pin instead of using the generated default.nix.
# Avoids boilerplate but couples to npins internals. Update packages with `npins update
# --lock-file <path/to/npins.json>`. This npinsLoader pattern can be reused by pointing
# it to any npins.json location - the generated default.nix is not required.
let
  npinsJson = ./npins.json |> builtins.readFile |> builtins.fromJSON;
  npinsPin = npinsJson.pins.npins;
  npinsLoader =
    npinsPin
    |> (
      pin:
      fetchTarball {
        inherit (pin) url;
        sha256 = pin.hash;
      }
    )
    |> (tarball: tarball + "/libnpins/src/default.nix")
    |> import;
  sources = npinsLoader { input = npinsJson; };
in
{
  inherit npinsJson npinsLoader sources;
}
