#{ lib, ... }:
{
  #  flake.modules.nixos.analfabeta.systemd.enableStrictShellChecks = lib.mkForce true;
}
