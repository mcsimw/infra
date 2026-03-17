{ config, ... }:
{
  nixpkgs.overlays = [
    {
      overlay = (import config.sources.nix-cachyos-kernel).overlays.default;
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
      ];
    }
  ];
}
