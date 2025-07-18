{
  moduleWithSystem,
  ...
}:
{
  flake.modules.nixos.desktop = moduleWithSystem (
    {
      inputs',
      self',
    }:
    {
      pkgs,
      inputs,
      config,
      lib,
      self,
      ...
    }:
    let
      dwl = pkgs.writeShellApplication {
        name = "dwl";
        runtimeInputs = [
          pkgs.swaybg
          (self'.packages.dwl.overrideAttrs (old: {
            patches = (old.patches or [ ]) ++ [ (self + "/dwl/sane.patch") ];
          }))
        ];
        text = ''
          dwl -s "
            dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_SESSION_TYPE;
            systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_SESSION_TYPE;
            swaybg -c '#CC0077'
          "
        '';
      };
    in
    {
      config = lib.mkIf config.programs.dwl.enable (
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
          (import ./_wlroots.nix {
            inherit
              pkgs
              inputs
              lib
              config
              self
              ;
          })
          {
            programs.uwsm = {
              enable = true;
              waylandCompositors.dwl = {
                prettyName = "dwl";
                comment = "dwl compositor managed by UWSM";
                binPath = "/run/current-system/sw/bin/dwl";
              };
            };
            programs.dwl = {
              package = lib.mkDefault dwl;
              extraSessionCommands = ''
                export SDL_VIDEODRIVER=wayland
                export QT_QPA_PLATFORM=wayland
                export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
                export _JAVA_AWT_WM_NONREPARENTING=1
                export MOZ_ENABLE_WAYLAND=1
                export XDG_SESSION_TYPE=wayland
                export XDG_CURRENT_DESKTOP=dwl
              '';

            };
          }
        ]
      );
    }
  );
}
