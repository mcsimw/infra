{ config, ... }:
{
  flake.modules.nixos = {
    default = config.flake.modules.nixos.udisks2;
    iso =
      { lib, ... }:
      {
        services.udisks2.enable = lib.mkForce true;
      };
    udisks2 =
      { lib, ... }:
      {
        services.udisks2.enable = lib.mkDefault true;
      };
  };
}
