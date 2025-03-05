{ config, inputs, ... }:
{
  perSystem =
    { pkgs, system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          inputs.nix.overlays.default
          inputs.neovim.overlays.default
          inputs.emacs.overlays.default
          inputs.wayland.overlays.default
          inputs.nyx.overlays.default
        ];
      };
    };
}
