{ lib, ... }:
{
  flake.modules.nixos.analfabeta.programs.wireshark.enable = lib.mkDefault true;
}
