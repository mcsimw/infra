{ lib, ... }:
{
  flake.modules.nixos.analfabeta.programs.appimage = {
    enable = lib.mkDefault true;
    binfmt = lib.mkDefault true;
  };
}
