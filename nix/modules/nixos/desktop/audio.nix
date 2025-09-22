{ moduleWithSystem, self, ... }:
{
  flake.modules.nixos.infra =
    (
      { self }:
      moduleWithSystem (
        { pkgs, ... }:
        { config, lib, ... }:
        let
          vars = import (self + /nix/modules/nixos/desktop/_vars.nix) config;
        in
        {
          config = lib.mkIf vars.minimal {
            environment.systemPackages = [ pkgs.pwvucontrol_git ];
          };
        }
      )
    )
      { inherit self; };
}
