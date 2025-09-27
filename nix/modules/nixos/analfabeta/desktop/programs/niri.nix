{ moduleWithSystem, ... }:
{
  flake.modules.nixos.analfabeta = moduleWithSystem (
    { inputs', ... }:
    { config, lib, ... }:
    {
      config = lib.mkIf config.analfabeta.desktop.enable {
        programs.niri = {
          enable = true;
          package = inputs'.niri.packages.default;
        };
      };
    }
  );
}
