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
          cfg = config.services.pipewire.enable;
        in
        {
          config = lib.mkIf (vars.minimal && cfg) {
            environment.systemPackages = [ pkgs.pwvucontrol_git ];
          };
        }
      )
    )
      { inherit self; };
}
