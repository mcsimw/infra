{
  lib,
  desktops,
  config,
  ...
}:
{
  flake.modules.nixos =
    let
      anyDesktop = cfg: lib.any (name: desktops.byName.${name}.check cfg) (lib.attrNames desktops.byName);
      toBackendList = value: if lib.isString value then lib.splitString ";" value else value;
      hasPortalBackend =
        cfg: backend:
        lib.any (portalCfg: lib.elem backend (toBackendList (portalCfg.default or ""))) (
          lib.attrValues cfg.xdg.portal.config
        );
    in
    {
      default = config.flake.modules.nixos.xdg;
      xdg =
        {
          config,
          pkgs,
          lib,
          ...
        }:
        {
          options.xdg.portal.gtk.enable = lib.mkEnableOption "xdg-desktop-portal-gtk";
          config.xdg.portal = {
            xdgOpenUsePortal = lib.mkDefault true;
            enable = anyDesktop config;
            wlr.enable = lib.mkIf (hasPortalBackend config "wlr") (lib.mkDefault true);
            gtk.enable = lib.mkIf (hasPortalBackend config "gtk") (lib.mkDefault true);
            extraPortals = lib.mkIf config.xdg.portal.gtk.enable [
              pkgs.xdg-desktop-portal-gtk
            ];
          };
        };
    };
}
