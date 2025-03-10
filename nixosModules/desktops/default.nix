{
  self,
  lib,
  inputs,
  ...
}:
{
  flake.nixosModules = {
    dwl = lib.modules.importApply ./dwl.nix { inherit self; };
    wlroots = lib.modules.importApply ./wlroots.nix { inherit inputs; };
    desktop-base = ./base.nix;
    gnome = ./gnome.nix;
  };
}
