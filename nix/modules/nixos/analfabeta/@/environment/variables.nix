{ lib, ... }:
{
  flake.modules.nixos.analfabeta.environment.variables.NIXPKGS_CONFIG = lib.mkDefault "";
}
