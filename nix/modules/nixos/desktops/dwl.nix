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
    let
      dwl = pkgs.writeShellApplication {
        name = "dwl";
        runtimeInputs = [
          pkgs.swaybg
          (self'.packages.dwl.overrideAttrs (old: {
            patches = (old.patches or [ ]) ++ [ (self + "/dwl/sane.patch") ];
          }))
        ];
        text = ''
          dwl -s "
            swaybg -c '#CC0077'
          "
        '';
      };
    in
    {
      config = lib.mkIf config.programs.dwl.enable (
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
          { programs.dwl.package = lib.mkDefault dwl; }
        ]
      );
    }
  );
}
