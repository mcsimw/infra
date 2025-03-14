{ self' }:
{ config, lib, ... }:
{
  users.users.mcsimw = {
    description = "Maor Haimovitz";
    isNormalUser = true;
    extraGroups = [ "wheel" ] ++ (import ./extraGroups.nix { inherit config lib; });
    uid = 1000;
    password = "1";
    packages = with self'.packages; [ git ];
  };
}
