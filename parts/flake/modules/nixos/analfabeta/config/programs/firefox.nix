{ moduleWithSystem, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { self' }:
    { config, ... }:
    {
      programs.firefox = {
        inherit (config.programs.niri) enable;
        package = self'.packages.firefox;
      };
    }
  );
}
