{
  flake.modules.nixos.analfabeta =
    { pkgs, ... }:
    {
      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-gnome
        ];
        config = {
          common.default = [ "gtk" ];
          niri = {
            default = [
              "gnome"
              "gtk"
            ];
            "org.freedesktop.impl.portal.Access" = "gtk";
            "org.freedesktop.impl.portal.Notification" = "gtk";
            "org.freedesktop.portal.RemoteDesktop" = "none";
            "org.freedesktop.portal.Wallpaper" = "none";
          };
        };
      };
    };
}
