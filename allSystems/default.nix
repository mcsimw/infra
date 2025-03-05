{ inputs, ... }:
{
  imports = [
    inputs.disk-abstractions.nixosModules.zfsonix
    inputs.disko.nixosModules.default
    inputs.impermanence.nixosModules.default
  ];
}
