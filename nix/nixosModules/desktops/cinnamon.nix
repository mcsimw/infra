{ inputs', self' }:
{
  pkgs,
  config,
  lib,
  self',
  ...
}:
{
  options.myShit.cinnamon.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    example = false;
    description = "Whether to enable cinnamon.";
  };

  config = lib.mkIf config.myShit.cinnamon.enable (
    lib.mkMerge [
      (import ./base.nix { inherit inputs' pkgs self'; })
      {
        xdg.portal = {
          enable = true;
          extraPortals = [
            pkgs.xdg-desktop-portal-gtk
          ];
          config.x-cinnamon.default = [
            "xapp"
            "gtk"
          ];
        };
        services = {
          cinnamon.apps.enable = true;
          dbus.packages = [ pkgs.dconf ];
          displayManager.defaultSession = "cinnamon";
          libinput.enable = true;
          xserver = {
            enable = true;
            displayManager.lightdm.enable = true;
            desktopManager.cinnamon.enable = true;
          };
        };
      }
    ]
  );
}
