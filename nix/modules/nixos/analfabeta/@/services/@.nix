{
  flake.modules.nixos.analfabeta =
    { lib, ... }:
    {
      services = {
        gpm.enable = lib.mkDefault true;
        pulseaudio.enable = lib.mkForce false;
        udisks2.enable = lib.mkDefault true;
        dbus.implementation = lib.mkForce "broker";
        userborn.enable = lib.mkForce true;
      };
    };
}
