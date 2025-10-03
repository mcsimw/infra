{ inputs, ... }:
{
  flake.modules.nixos.analfabeta.imports = [ inputs.hjem.nixosModules.default ];
}
