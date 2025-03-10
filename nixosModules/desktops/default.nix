{ self, lib, ... }:
{
  flake.nixosModules = {
    dwl = lib.modules.importApply ./dwl.nix { inherit self; };
  };
}
