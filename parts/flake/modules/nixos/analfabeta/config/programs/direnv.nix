{ lib, ... }:
{
  flake.modules.nixos.analfabeta.programs.direnv.enable = lib.mkDefault true;
}
