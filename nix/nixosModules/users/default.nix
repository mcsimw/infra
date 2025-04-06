{ moduleWithSystem, ... }:
{
  flake.nixosModules.mcsimw = moduleWithSystem ({ self' }: import ./mcsimw { inherit self'; });
}
