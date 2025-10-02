{ lib, ... }:
{
  flake.modules.nixos.analfabeta =
    { config, ... }:
    {
      services.xserver.desktopManager.runXdgAutostartIfNone = lib.mkForce config.programs.niri.enable;
    };
}
