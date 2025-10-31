{ lib, config, ... }:
{
  boot.loader.grub.memtest86.enable = lib.mkForce true;
  isoImage.makeBiosBootable = lib.mkDefault (!config.boot.loader.systemd-boot.enable);
  users.users = {
    nixos.enable = lib.mkForce false;
    mcsimw.enable = lib.mkForce true;
  };
}
