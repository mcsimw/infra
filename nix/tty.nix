{ config, ... }:
{
  flake.modules.nixos = {
    default = config.flake.modules.nixos.tty;
    tty =
      { lib, ... }:
      {
        services.gpm.enable = lib.mkDefault true;
      };
  };
}
