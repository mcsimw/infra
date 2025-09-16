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
          inputs.neovim-nightly-overlay.overlays.default
          inputs.emacs-overlay.overlays.default
          inputs.nixpkgs-wayland.overlays.default
          inputs.nyx.overlays.cache-friendly
          (_final: prev: { xdg-desktop-portal-wlr = prev.xdg-desktop-portal-wlr_git; })
        ];
      };
      inherit
        ((inputs.wrapper-manager.lib {
          inherit (_module.args) pkgs;
          modules =
            let
              dirNames = builtins.attrNames (
                lib.filterAttrs (_n: t: t == "directory") (builtins.readDir ./_wrapper-manager)
              );
            in
            map (n: ./_wrapper-manager/${n}) dirNames;
          specialArgs = { inherit self inputs'; };
        }).config.build
        )
        packages
        ;
    };
}
