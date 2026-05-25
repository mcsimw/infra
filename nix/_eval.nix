inputs:
let
  npins = import ./_npins.nix;
  inherit (npins) npinsLoader sources;
  lib = import "${sources.nixpkgs}/lib";
  evaluated = lib.evalModules {
    class = "flake";
    specialArgs = { inherit sources inputs; };
    modules = [
      { config._module.args = { inherit npinsLoader; }; }
      ./_import-tree.nix
    ];
  };
in
evaluated // { flake = evaluated.config.flake; }
