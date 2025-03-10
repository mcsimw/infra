{ self, ... }:
{ lib, pkgs, ... }:
{
  imports = [
    self.lanzaboote.nixosModules.lanzaboote
    ./efi.nix
  ];
  environment.systemPackages = [
    pkgs.sbctl
  ];
  boot = {
    loader.efi.canTouchEfiVariables = lib.mkForce true;
    loader.systemd-boot.enable = lib.mkForce false;
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };
}
