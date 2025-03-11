# A lot of this is adapted from viperML's dotfiles (https://github.com/viperML/dotfiles) under EUPL-1.2.
{
  config,
  inputs,
  lib,
  ...
}:
{
  perSystem =
    {
      pkgs,
      system,
      inputs',
      ...
    }:
    {
      packages = lib.fix (
        _self:
        let
          stage1 = lib.fix (
            self':
            let
              callPackage = lib.callPackageWith <| pkgs // self';

              auto = lib.pipe (builtins.readDir ./.) [
                (lib.filterAttrs (_name: value: value == "directory"))
                (builtins.mapAttrs (name: _: callPackage ./${name} { }))
              ];
            in
            auto
            // {
              dwl = callPackage ./dwl.nix {
                inherit pkgs;
              };
            }
          );
          stage2 =
            stage1
            // (inputs.wrapper-manager.lib {
              pkgs = pkgs // stage1;
              modules = lib.pipe (builtins.readDir ../wrapped-packages) [
                (lib.filterAttrs (_name: value: value == "directory"))
                builtins.attrNames
                (map (n: ../wrapped-packages/${n}))
              ];
              specialArgs = {
                inherit inputs';
              };
            }).config.build.packages;

          # packages that depend on wrappers
          stage3 = stage2 // {

          };
        in
        stage3
      );

      # Provide pkgs to the module system
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          inputs.nix.overlays.default
          inputs.neovim-nightly-overlay.overlays.default
          inputs.emacs-overlay.overlays.default
          inputs.nixpkgs-wayland.overlays.default
          inputs.nyx.overlays.default
        ];
      };
    };
}
