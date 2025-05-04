{ inputs, ... }:
{
  perSystem =
    { system, pkgs, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          inputs.nix.overlays.default
          inputs.neovim-nightly-overlay.overlays.default
          inputs.emacs-overlay.overlays.default
          inputs.nixpkgs-wayland.overlays.default
          inputs.nyx.overlays.cache-friendly
        ];
      };
    };
}
