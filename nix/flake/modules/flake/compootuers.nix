{ self, lib, ... }:
let
  compootuers = lib.modules.importApply ./_compootuers.nix { localFlake = self; };
in
{
  inherit (compootuers) imports;
  flake = {
    modules.flake = { inherit compootuers; };
    compootuers = {
      perSystem = ../../../compootuers/perSystem;
      allSystems = ../../../compootuers/allSystems;
    };
  };
}
