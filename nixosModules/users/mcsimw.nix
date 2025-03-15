{ self' }:
{ config, lib, pkgs, ... }:
{
  environment.shells = [ pkgs.nushell ];
  users.users.mcsimw = {
    description = "Maor Haimovitz";
    isNormalUser = true;
    extraGroups = [ "wheel" ] ++ (import ./extraGroups.nix { inherit config lib; });
    uid = 1000;
    password = "1";
    packages = with self'.packages; [ git nushell neovim ];
    shell = "/etc/profiles/per-user/mcsimw/bin/nu";
  };
}

