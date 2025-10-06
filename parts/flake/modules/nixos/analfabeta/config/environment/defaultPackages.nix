{ lib, ... }:
{
  flake.modules.nixos.analfabeta.environment.defaultPackages = lib.mkForce [ ];
}
