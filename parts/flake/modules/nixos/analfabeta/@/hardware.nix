{ moduleWithSystem, lib, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    _:
    { config, ... }:
    {
      hardware.graphics = {
        enable = lib.mkForce config.programs.niri.enable;
        enable32Bit = lib.mkForce config.programs.niri.enable;
      };
    }
  );
}
