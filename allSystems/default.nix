{ inputs, ... }:
{
  imports = [
    inputs.disko.nixosModules.default
    inputs.impermanence.nixosModules.default
  ];
}
