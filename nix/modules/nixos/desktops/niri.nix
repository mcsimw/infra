{ moduleWithSystem, ... }:
{
  flake.modules.nixos.desktop = moduleWithSystem (
    { inputs', self', ... }:
    {
      pkgs,
      config,
      lib,
      ...
    }:
    {
      config = lib.mkIf (config.analfabeta.desktop == "niri") (
        lib.mkMerge [
          (import ./_base.nix {
            inherit
              inputs'
              pkgs
              self'
              lib
              config
              ;
          })
          (import ./_minimal.nix { inherit pkgs config lib; })
          {
            programs = {
              niri = {
                enable = true;
                package = inputs'.niri.packages.niri;
              };
              uwsm = {
                waylandCompositors.niri = {
                  prettyName = "Niri";
                  comment = "Niri compositor managed by UWSM";
                  # https://github.com/YaLTeR/niri/issues/254
                  binPath = pkgs.writeShellScript "niri" ''
                    ${lib.getExe config.programs.niri.package} --session
                  '';
                };
              };
            };
            xdg.portal = {
              extraPortals = with pkgs; [
                xdg-desktop-portal-gtk
                xdg-desktop-portal-gnome
              ];
              config = {
                niri = {
                  default = "gnome";
                  "org.freedesktop.impl.portal.FileChooser" = "gtk";
                };
                obs.default = [ "gnome" ];
              };
            };
            environment.systemPackages = [ inputs'.xwayland-satellite.packages.default ];
          }
        ]
      );
    }
  );
}
