{ lib, ... }:
{
  flake.modules.nixos.analfabeta.security.polkit.enable = lib.mkDefault true;
}
