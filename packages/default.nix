# A lot of this is adapted from viperML's dotfiles (https://github.com/viperML/dotfiles) under EUPL-1.2.
{
  config,
  inputs,
  ...
}:
{
  perSystem =
    {
      pkgs,
      system,
      ...
    }:
    {
      packages = {
        dwl = pkgs.callPackage ./dwl.nix { };
      };
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
