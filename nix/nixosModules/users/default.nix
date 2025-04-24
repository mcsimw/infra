{ moduleWithSystem, ... }:
{
  flake.nixosModules = {
    mcsimw = moduleWithSystem ({ self' }: import ./mcsimw.nix { inherit self'; });
    eyal = moduleWithSystem ({ self' }: import ./eyal.nix { inherit self'; });
  };
}
