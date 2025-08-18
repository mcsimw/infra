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
      config = lib.mkIf config.programs.niri.enable (
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
          (import ./_minimal.nix { inherit pkgs config; })
          {
            programs.niri.package = inputs'.niri.packages.niri;
            environment.systemPackages = [ inputs'.xwayland-satellite.packages.default ];
          }
        ]
      );
    }
  );
}
