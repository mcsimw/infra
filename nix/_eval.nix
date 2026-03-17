let
  npins = import ./_npins.nix;
  inherit (npins) npinsLoader sources;
  lib = import "${sources.nixpkgs}/lib";
  evalArgs = {
    class = "flake";
    specialArgs = { inherit sources; };
    modules = [
      { config._module.args = { inherit npinsLoader; }; }
      ./_import-tree.nix
    ];
  };
  evaluated = lib.evalModules evalArgs;
in
evaluated // { flake = evaluated.config.flake; }
