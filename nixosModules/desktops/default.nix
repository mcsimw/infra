{
  self,
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules = {
    dwl = moduleWithSystem ({ self' }: import ./dwl.nix { inherit self self'; });
    wlroots = ./wlroots.nix;
    desktop-base = moduleWithSystem ({ self', inputs' }: import ./base.nix { inherit self' inputs'; });
    gnome = ./gnome.nix;
  };
}
