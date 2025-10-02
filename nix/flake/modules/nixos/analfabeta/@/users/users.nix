{ lib, ... }:
{
  flake.modules.nixos.analfabeta.users.users.mutableUsers = lib.mkForce false;
}
