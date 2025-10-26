{ moduleWithSystem, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { inputs' }:
    {
      programs.niri.package = inputs'.niri.packages.default;
    }
  );

}
