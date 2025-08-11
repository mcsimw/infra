{ lib, self, ... }:
{
  flake.modules.maid.git = lib.modules.importApply ./_git.nix { localFlake = self; };
}
