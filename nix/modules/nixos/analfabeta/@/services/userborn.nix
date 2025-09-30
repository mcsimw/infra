{ lib, ... }:
{
  flake.modules.nixos.analfabeta.services.userborn.enable = lib.mkForce true;
}

