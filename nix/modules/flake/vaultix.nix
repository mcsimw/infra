{ inputs, self, ... }:
{
  imports = [ inputs.vaultix.flakeModules.default ];
  flake.vaultix = {
    nodes = self.nixosConfigurations;
  };
}
