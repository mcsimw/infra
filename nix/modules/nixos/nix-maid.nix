{ inputs, ... }:
{
  flake.modules.nixos.infra =
    ({ inputs }: _: { imports = [ inputs.nix-maid.nixosModules.default ]; })
      { inherit inputs; };
}
