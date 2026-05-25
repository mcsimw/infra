{ inputs, ... }:
{
  nixpkgs.overlays = [
    {
      overlay = (import inputs.nix-cachyos-kernel).overlays.default;
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
      ];
    }
  ];
}
