{ lib, config, ... }:
{
  boot.loader.grub.memtest86.enable = lib.mkForce true;
  isoImage.makeBiosBootable = lib.mkDefault (!config.boot.loader.systemd-boot.enable);
}
