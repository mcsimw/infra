{ moduleWithSystem, lib, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { inputs' }:
    {
      programs.niri.package = lib.mkDefault inputs'.niri.packages.default;
    }
  );
}
