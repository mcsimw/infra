{ lib, ... }:
{
  flake.modules.nixos.analfabeta.hjem.clobberByDefault = lib.mkDefault true;
}
