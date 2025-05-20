{
  moduleWithSystem,
  self,
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
      ...
    }:
    {
      options.myShit.desktop.dwl.enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable dwl.";
      };

      config = lib.mkIf config.myShit.desktop.dwl.enable (
        lib.mkMerge [
          (import ./_base.nix { inherit inputs' pkgs self'; })
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
            services.dbus.packages = [ pkgs.dconf ];
            environment.systemPackages = [ pkgs.dwl ];
            xdg.portal.config.dwl.default = [
              "wlr"
              "gtk"
            ];
          }
        ]
      );
    }
  );
}
