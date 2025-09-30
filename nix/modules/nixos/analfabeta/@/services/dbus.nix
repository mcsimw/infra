{ lib, ... }:
{
  flake.modules.nixos.analfabeta.services.dbus.implementation = lib.mkForce "broker";
}
