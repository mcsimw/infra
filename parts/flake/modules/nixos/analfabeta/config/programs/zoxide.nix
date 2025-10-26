{ lib, ... }:
{
  flake.modules.nixos.analfabeta.programs.zoxide.enable = lib.mkDefault true;
}
