{
  self,
  lib,
  inputs,
  ...
}:
{
  flake.nixosModules = {
    dwl = lib.modules.importApply ./dwl.nix { inherit self; };
    wlroots = ./wlroots.nix;
    desktop-base = lib.modules.importApply ./base.nix { inherit self inputs; };
    gnome = ./gnome.nix;
  };
}
