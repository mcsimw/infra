{
  inputs,
  self,
  lib,
  ...
}:
{
  imports = [ inputs.vaultix.flakeModules.default ];
  flake.vaultix = {
    nodes = lib.filterAttrs (name: _: !lib.hasSuffix "-iso" name) self.nixosConfigurations;
  };
}
