{ lib, self, ... }:
{
  imports = [ self.nixosModules.efi-packages ];
  boot.loader = {
    systemd-boot = {
      enable = lib.mkForce true;
      editor = lib.mkForce false;
    };
    efi.canTouchEfiVariables = lib.mkForce true;
  };
}
