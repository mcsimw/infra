{ inputs, ... }:
{
  flake.modules.nixos.analfabeta =
    (
      { inputs }:
      _: {
        imports = [ inputs.hjem.nixosModules.default ];
        hjem.clobberByDefault = true;
      }
    )
      { inherit inputs; };
}
