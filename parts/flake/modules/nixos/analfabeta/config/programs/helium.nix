{
  flake.modules.nixos.analfabeta =
    { config, ... }:
    {
      programs.helium.enable = config.programs.niri.enable;
    };
}
