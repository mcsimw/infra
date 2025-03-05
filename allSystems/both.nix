{ lib, pkgs, ... }:
{
  time.timeZone = lib.mkDefault "Canada/Eastern";
  security.sudo.wheelNeedsPassword = lib.mkDefault true;
  environment.systemPackages = with pkgs; [
    kakoune
  ];
}
