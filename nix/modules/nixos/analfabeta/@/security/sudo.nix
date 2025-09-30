{ lib, ... }:
{
  flake.modules.nixos.analfabeta.security.sudo = {
    wheelNeedsPassword = lib.mkDefault false;
    execWheelOnly = lib.mkForce true;
  };
}
