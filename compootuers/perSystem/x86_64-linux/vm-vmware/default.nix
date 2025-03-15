{
  packages,
  self,
  lib,
  ...
}:
{
  imports = [
    ./hardware.nix
    ./fileSystems.nix
    self.nixosModules.systemd-bootloader
  ];
  users.users.mcsimw.packages = with packages; [
    foot
  ];
  systemd.targets = {
    sleep.enable = lib.mkForce false;
    suspend.enable = lib.mkForce false;
    hibernate.enable = lib.mkForce false;
    hybrid-sleep.enable = lib.mkForce false;
  };
}
