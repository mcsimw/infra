{ lib, ... }:
{
  boot.loader.grub.memtest86.enable = lib.mkForce true;
}
