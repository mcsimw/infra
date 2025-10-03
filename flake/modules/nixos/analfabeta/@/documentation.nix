{ lib, ... }:
{
  flake.modules.nixos.analfabeta.documentation = lib.genAttrs [ "doc" "nixos" "info" ] (_: {
    enable = lib.mkForce false;
  });
}
