{
  flake.modules.nixos.analfabeta =
    { config, ... }:
    {
      services.blueman.enable = config.hardware.bluetooth.enable && config.programs.niri.enable;
    };
}
