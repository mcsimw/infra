{ lib, ... }:
{
  flake.modules.nixos.analfabeta.services.gpm.enable = lib.mkDefault true;
}
