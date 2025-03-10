{ lib, pkgs, ... }:
{
  boot.loader = {
    systemd-boot = {
      enable = lib.mkForce true;
      editor = lib.mkForce false;
    };
    efi.canTouchEfiVariables = lib.mkForce true;
  };
  environment.systemPackages = [ pkgs.efibootmgr ];
}
