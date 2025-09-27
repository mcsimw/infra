{
  flake.modules.nixos.analfabeta =
    { lib, ... }:
    {
      documentation = lib.genAttrs [ "doc" "nixos" "info" ] (_: {
        enable = lib.mkForce false;
      });
    };
}
