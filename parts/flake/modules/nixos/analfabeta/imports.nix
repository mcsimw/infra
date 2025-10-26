{ inputs, ... }:
{
  flake.modules.nixos.analfabeta.imports = with inputs; [
    hjem.nixosModules.default
    emoji-picker-nix.nixosModules.default
    walker.nixosModules.default
  ];
}
