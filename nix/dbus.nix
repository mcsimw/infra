{ config, ... }:
{
  flake.modules.nixos = {
    default = config.flake.modules.nixos.dbus;
    dbus =
      { lib, ... }:
      {
        services.dbus.implementation = lib.mkDefault "broker";
      };
  };
}
