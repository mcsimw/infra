{
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.dwl = moduleWithSystem (
    { inputs', self' }: import ./dwl.nix { inherit inputs' self'; }
  );
}
