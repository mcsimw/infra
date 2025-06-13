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
          (import ./_tilingwm.nix { inherit pkgs config; })
          { environment.systemPackages = [ inputs'.xwayland-satellite.packages.default ]; }
        ]
      );
    }
  );
}
