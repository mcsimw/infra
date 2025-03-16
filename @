{
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules = {
    dwl = moduleWithSystem ({ self', inputs' }: import ./dwl.nix { inherit self' inputs'; });
    gnome = ./gnome.nix;
  };
}
