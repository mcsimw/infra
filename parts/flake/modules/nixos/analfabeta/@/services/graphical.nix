{ lib, ... }:
{
  flake.modules.nixos.analfabeta =
    { config, ... }:
    {
      services.graphical-desktop.enable = lib.mkForce config.programs.niri.enable;
    };
}
