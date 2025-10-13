{ inputs, ... }:
{
  perSystem =
    { system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = with inputs; [
          nur.overlays.default
          nixpkgs-wayland.overlay
          chaotic.overlays.cache-friendly
          emacs-overlay.overlays.default
          nix.overlays.default
        ];
      };

    };
}
