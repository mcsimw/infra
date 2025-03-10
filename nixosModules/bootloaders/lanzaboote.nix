{ self, ... }:
{ lib, ... }:
{
  imports = [
    self.lanzaboote.nixosModules.lanzaboote
  ];
  boot.loader.efi.canTouchEfiVariables = false;
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/secureboot";
  };
}
