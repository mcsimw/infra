{ lib, ... }:
{
  isoImage.makeBiosBootable = lib.mkForce false;
}
