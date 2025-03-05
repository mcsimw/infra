{ lib, pkgs, ... }:
{
  time.timeZone = lib.mkDefault "Canada/Eastern";
  security.sudo.wheelNeedsPassword = lib.mkDefault true;
  environment.systemPackages = with pkgs; [
    kakoune
  ];
  nix.settings = {
    substituters = [
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
