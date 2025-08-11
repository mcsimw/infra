{ lib, self, ... }:
{
  flake.modules.maid = {
    git = lib.modules.importApply ./_git.nix { inherit self; };
    mpv = lib.modules.importApply ./_mpv.nix { inherit self; };
  };
}
