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
        overlays = [ inputs.nix.overlays.default ];
      };
      inherit
        ((inputs.wrapper-manager.lib {
          inherit (_module.args) pkgs;
          modules =
            let
              wrappersPath = self + /wrappers;
              dirNames = builtins.attrNames (
                lib.filterAttrs (_n: t: t == "directory") (builtins.readDir wrappersPath)
              );
            in
            map (n: wrappersPath + "/${n}") dirNames;
          specialArgs = { inherit self inputs'; };
        }).config.build
        )
        packages
        ;
    };
}
