{ moduleWithSystem, ... }:
{
  flake.modules.nixos.infra = moduleWithSystem (
    { pkgs, ... }:
    {
      config,
      lib,
      ...
    }:
    let
      cfg = config.analfabeta.desktop;
    in
    {
      config = lib.mkIf cfg.enable {
        xdg.portal = {
          enable = true;
          extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
          config = {
            common.default = [ "gtk" ];
          };
          wlr.enable = cfg.wlroots;
        };
      };
    }
  );
}
