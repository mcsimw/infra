{ lib, ... }:
{
  flake.modules.nixos.analfabeta.networking = {
    useDHCP = lib.mkDefault true;
    networkmanager = {
      enable = lib.mkForce false;
      wifi.powersave = lib.mkDefault false;
    };
    wireless.enable = lib.mkForce false;
    useNetworkd = lib.mkDefault true;
  };
}
