{ lib, ... }:
{
  flake.modules.nixos.analfabeta.security.rtkit.enable = lib.mkDefault true;
}
