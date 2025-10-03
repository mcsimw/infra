{
  inputs,
  lib,
  self,
  ...
}:
{
  perSystem =
    { system, inputs', ... }:
    rec {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          inputs.nix.overlays.default
          inputs.nixpkgs-wayland.overlays.default
          inputs.nyx.overlays.cache-friendly
          inputs.nur.overlays.default
        ];
      };
      inherit
        ((inputs.wrapper-manager.lib {
          inherit (_module.args) pkgs;
          modules =
            let
              dirNames = builtins.attrNames (
                lib.filterAttrs (_n: t: t == "directory") (builtins.readDir ../../wrappers)
              );
            in
            map (n: ../../wrappers/${n}) dirNames;
          specialArgs = { inherit self inputs'; };
        }).config.build
        )
        packages
        ;
    };
}
