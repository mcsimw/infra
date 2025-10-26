{ lib, ... }:
{
  flake.modules.nixos.analfabeta =
    { config, ... }:
    {
      programs.starship = {
        enable = lib.mkDefault config.programs.niri.enable;
        settings.add_newline = lib.mkDefault false;
      };
    };
}
