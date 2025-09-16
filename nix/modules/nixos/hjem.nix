{ inputs, ... }:
{
  flake.modules.nixos.infra =
    (
      { inputs }:
      _: {
        imports = [ inputs.hjem.nixosModules.default ];
        hjem.clobberByDefault = true;
      }
    )
      { inherit inputs; };
}
