{ moduleWithSystem, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { inputs' }:
    _: {
      programs.niri.package = inputs'.niri.packages.default;
    }
  );

}
