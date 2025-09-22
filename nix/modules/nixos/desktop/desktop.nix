{ self, ... }:
{
  flake.modules.nixos.infra =
    (
      { self }:
      {
        config,
        lib,
        pkgs,
        ...
      }:
      let
        vars = import (self + /nix/modules/nixos/desktop/_vars.nix) config;
      in
      {
        config = lib.mkIf vars.desktop {
          services = {
            xserver.desktopManager.runXdgAutostartIfNone = lib.mkForce true;
            graphical-desktop.enable = lib.mkForce true;
            dbus.packages = [ pkgs.dconf ];
          };
          hardware.graphics = {
            enable = lib.mkForce true;
            enable32Bit = lib.mkForce true;
          };
        };
      }
    )
      { inherit self; };
}
