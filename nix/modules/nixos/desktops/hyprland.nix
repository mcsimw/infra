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
      config,
      lib,
      ...
    }:
    {
      options.myShit.desktop.hyprland.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable hyprland.";
      };

      config = lib.mkIf config.myShit.desktop.hyprland.enable (
        lib.mkMerge [
          (import ./_base.nix { inherit inputs' pkgs self'; })
          (import ./_tilingwm.nix { inherit pkgs; })
          {
            programs.hyprland = {
              enable = true;
              package = inputs'.hyprland.packages.hyprland;
              portalPackage = inputs'.hyprland.packages.xdg-desktop-portal-hyprland;
            };
          }
        ]
      );
    }
  );
}
