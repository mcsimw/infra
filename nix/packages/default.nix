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
          inputs.niri.overlays.default
          (import ./nvim/_plugins.nix { inherit inputs; })
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
          specialArgs = {
            inherit self inputs';
            dotfiles = "${self}/dotfiles";
          };
        }).config.build
        )
        packages
        ;
    };
}
