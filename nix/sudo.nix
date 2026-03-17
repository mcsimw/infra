{ config, ... }:
{
  flake.modules.nixos.default = config.flake.modules.nixos.sudo;
  flake.modules.nixos.sudo =
    { lib, ... }:
    {
      security.sudo = {
        wheelNeedsPassword = lib.mkDefault false;
        execWheelOnly = lib.mkForce true;
      };
    };
}
