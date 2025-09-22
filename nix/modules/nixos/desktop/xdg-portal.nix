{ moduleWithSystem, self, ... }:
{
  flake.modules.nixos.infra =
    (
      { self }:
      moduleWithSystem (
        { pkgs, ... }:
        {
          config,
          lib,
          ...
        }:
        let
          vars = import (self + /nix/modules/nixos/desktop/_vars.nix) config;
        in
        {
          config = lib.mkIf vars.desktop {
            xdg.portal = {
              enable = true;
              extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
              config = {
                common.default = [ "gtk" ];
              };
              wlr.enable = vars.wlroots;
            };
          };
        }
      )
    )
      { inherit self; };
}
