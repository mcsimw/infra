{ lib, ... }:
{
  flake.modules.nixos.analfabeta.i18n.extraLocaleSettings.LC_TIME = lib.mkDefault "C.UTF-8";
}
