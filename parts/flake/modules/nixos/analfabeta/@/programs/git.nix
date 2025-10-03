{ lib, ... }:
{
  flake.modules.nixos.analfabeta.programs.git = {
    enable = lib.mkForce true;
    lfs.enable = lib.mkDefault true;
  };
}
