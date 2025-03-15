{
  self,
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules = {
    desktop-base = moduleWithSystem ({ self', inputs' }: import ./base.nix { inherit inputs'; });
    wlroots = ./wlroots.nix;
    dwl = moduleWithSystem ({ self' }: import ./dwl.nix { inherit self self'; });
    gnome = ./gnome.nix;
  };
}
