{ moduleWithSystem, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { inputs', ... }:
    { config, lib, ... }:
    {
      config = lib.mkIf config.analfabeta.desktop.enable {
        programs.firefox = {
          enable = true;
          package = inputs'.flake-firefox-nightly.packages.firefox-nightly-bin;
        };
      };
    }
  );
}
