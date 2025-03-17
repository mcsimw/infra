{
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules = {
    dwl = moduleWithSystem ({ inputs' }: import ./dwl.nix { inherit inputs'; });
    gnome = ./gnome.nix;
  };
}
