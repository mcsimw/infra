{ lib, ... }:
{
  flake.modules.nixos.analfabeta.programs.nano.enable = lib.mkForce false;
}
