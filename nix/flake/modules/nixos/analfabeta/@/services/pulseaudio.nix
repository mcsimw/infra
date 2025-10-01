{ lib, ... }:
{
  flake.modules.nixos.analfabeta.services.pulseaudio.enable = lib.mkForce false;
}
