{ lib, ... }:
{
  flake.modules.nixos.analfabeta.services.udisks2.enable = lib.mkDefault true;
}
