{ lib, ... }:
{
  flake.modules.nixos.analfabeta.programs.command-not-found.enable = lib.mkForce false;
}
