{ inputs, ... }:
{
  flake.modules.nixos.hjem = {
    imports = [ inputs.hjem.nixosModules.default ];
    hjem.clobberByDefault = true;
  };
}
