{ self, lib, ... }:
let
  yes = lib.modules.importApply ./_compootuers.nix { localFlake = self; };
in
{
  flake.modules.flake.compootuers = yes;
  compootuers = {
    perSystem = ../../compootuers/perSystem;
    allSystems = ../../compootuers/allSystems;
  };
  imports = [ yes ];
}
