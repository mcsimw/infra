{ lib, ... }:
{
  flake.modules.nixos.analfabeta =
    { pkgs, ... }:
    {
      services.dbus = {
        implementation = lib.mkForce "broker";
        packages = [ pkgs.dconf ];
      };
    };
}
