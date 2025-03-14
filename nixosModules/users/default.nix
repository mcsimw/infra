{ moduleWithSystem, ... }:
{
  flake.nixosModules.mcsimw = moduleWithSystem ({ self' }: import ./mcsimw.nix { inherit self'; });
}
