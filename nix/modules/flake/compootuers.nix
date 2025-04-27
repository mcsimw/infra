{ self, lib, ... }:
{
  flake.modules.flake.compootuers = lib.modules.importApply ./_compootuers.nix { localFlake = self; };
}
