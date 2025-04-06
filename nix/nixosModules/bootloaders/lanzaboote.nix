{ self, ... }:
{ lib, pkgs, ... }:
{
  imports = with self; [
    lanzaboote.nixosModules.lanzaboote
  ];
  environment.systemPackages = [
    pkgs.sbctl
    efibootmgr
  ];
  boot = {
    loader.efi.canTouchEfiVariables = lib.mkForce false;
    loader.systemd-boot.enable = lib.mkForce false;
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };
}
