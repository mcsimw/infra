{
  moduleWithSystem,
  ...
}:
{
  flake.modules.nixos.desktop = moduleWithSystem (
    {
      inputs',
      self',
    }:
    {
      pkgs,
      inputs,
      config,
      lib,
      self,
      ...
    }:
    {
      config = lib.mkIf config.programs.hyprland.enable (
        lib.mkMerge [
          (import ./_base.nix {
            inherit
              inputs'
              pkgs
              self'
              lib
              config
              ;
          })
          (import ./_wlroots.nix {
            inherit
              pkgs
              inputs
              lib
              config
              self
              ;
          })
          {
            programs.hyprland = {
              package = lib.mkDefault inputs'.hyprland.packages.hyprland;
              portalPackage = lib.mkDefault inputs'.hyprland.packages.xdg-desktop-portal-hyprland;
              withUWSM = true;
            };
          }
        ]
      );
    }
  );
}
