{
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules = {
    dwl = moduleWithSystem ({ inputs', self' }: import ./dwl.nix { inherit inputs' self'; });
    cinnamon = moduleWithSystem ({ inputs', self' }: import ./cinnamon.nix { inherit inputs' self'; });
  };
}
