{ lib, ... }:
{
  flake.modules.nixos.analfabeta.users.mutableUsers = lib.mkForce false;
}
