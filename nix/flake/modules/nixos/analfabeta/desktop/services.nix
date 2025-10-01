{ lib, ... }:
{
  flake.modules.nixos.analfabeta =
    { config, pkgs, ... }:
    {
      config = lib.mkIf config.analfabeta.desktop.enable {
        services = {
          blueman.enable = lib.mkIf config.hardware.bluetooth.enable true;
          xserver.desktopManager.runXdgAutostartIfNone = lib.mkForce true;
          graphical-desktop.enable = lib.mkForce true;
          dbus.packages = [ pkgs.dconf ];
        };
      };
    };
}
