{
  flake.modules.nixos.analfabeta =
    { lib, ... }:
    {
      security.sudo = {
        wheelNeedsPassword = lib.mkDefault false;
        execWheelOnly = lib.mkForce true;
      };
    };
}
