{ inputs, ... }:
{
  flake.modules.nixos.hjem =
    (
      { inputs }:
      {
        imports = [ inputs.hjem.nixosModules.default ];
        hjem.clobberByDefault = true;
      }
    )
      { inherit inputs; };
}

