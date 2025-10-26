{ moduleWithSystem, lib, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { inputs' }:
    { config, ... }:
    {
      programs.firefox = {
        inherit (config.programs.niri) enable;
        package = lib.mkDefault inputs'.flake-firefox-nightly.packages.firefox-nightly-bin;
      };
    }
  );
}
