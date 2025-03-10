{ inputs, self, ... }:
{
  imports = [
    inputs.disko.nixosModules.default
    inputs.impermanence.nixosModules.default
    inputs.nixpkgs.nixosModules.readOnlyPkgs
    #    inputs.vaultix.nixosModules.default
    self.nixosModules.users-default
    self.nixosModules.mcsimw-mkUser
    self.nixosModules.mcsimw-default
  ];
}
