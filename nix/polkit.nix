{ config, ... }:
{
  flake.modules.nixos = {
    default = config.flake.modules.nixos.polkit;
    polkit =
      { lib, ... }:
      {
        security.polkit.enable = lib.mkForce true;
      };
  };
}
