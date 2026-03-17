{ config, ... }:
{
  flake.modules.nixos = {
    default = config.flake.modules.nixos.pulseaudio;
    pulseaudio =
      { lib, ... }:
      {
        services.pulseaudio.enable = lib.mkForce false;
      };
  };
}
