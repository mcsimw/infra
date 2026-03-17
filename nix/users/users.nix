{ config, ... }:
{
  flake.modules.nixos = {
    default = config.flake.modules.nixos.users;
    users =
      { lib, ... }:
      {
        users.mutableUsers = lib.mkForce false;
        services.userborn.enable = lib.mkForce true;
      };
  };
}
