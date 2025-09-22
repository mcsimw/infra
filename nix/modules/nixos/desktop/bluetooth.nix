{ self, ... }:
{
  flake.modules.nixos.infra =
    (
      { self }:
      {
        config,
        ...
      }:
      let
        vars = import (self + /nix/modules/nixos/desktop/_vars.nix) config;
      in
      {
        services.blueman.enable = config.hardware.bluetooth.enable && vars.minimal;
      }
    )
      { inherit self; };
}
