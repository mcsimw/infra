{
  lib,
  config,
  inputs,
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
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;

        overlays = [
          inputs.nix.overlays.default
          inputs.neovim-nightly-overlay.overlays.default
          inputs.emacs-overlay.overlays.default
          inputs.nixpkgs-wayland.overlays.default
          inputs.nyx.overlays.cache-friendly
        ];

        config.allowUnfree = true;
      };

      packages = lib.fix (
        _self:
        let
          stage1 = lib.fix (
            self':
            let
              callPackage = lib.callPackageWith (pkgs // self');

              auto = lib.pipe (builtins.readDir ./.) [
                (lib.filterAttrs (name: value: value == "directory" && name != "wrapper-manager"))
                (builtins.mapAttrs (name: _: callPackage ./${name} { }))
              ];
            in
            auto
          );

          stage2 =
            stage1
            // (inputs.wrapper-manager.lib {
              pkgs = pkgs // stage1;
              modules = lib.pipe (builtins.readDir ./wrapper-manager) [
                (lib.filterAttrs (_name: value: value == "directory"))
                builtins.attrNames
                (map (n: ./wrapper-manager/${n}))
              ];
              specialArgs = {
                inherit inputs' inputs;
              };
            }).config.build.packages;

          stage3 = stage2;
        in
        stage3
      );
    };
}
