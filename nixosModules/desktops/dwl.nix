{ inputs', self' }:
{
  pkgs,
  inputs,
  config,
  lib,
  self',
  ...
}:
let
  dwl = pkgs.writeShellScriptBin "dwl" ''
    ${self'.packages.dwl}/bin/dwl -s "
      dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_SESSION_TYPE XDG_CURRENT_DESKTOP=dwl;
      systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_SESSION_TYPE;
      systemctl --user start yes.target;
    "
  '';
in
{
  options.myShit.dwl.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    example = false;
    description = "Whether to enable dwl.";
  };

  config = lib.mkIf config.myShit.dwl.enable (
    lib.mkMerge [
      (import ./base.nix { inherit inputs' pkgs self'; })
      (import ./wlroots.nix {
        inherit
          inputs'
          pkgs
          inputs
          config
          ;
      })
      {
        services.dbus.packages = [ pkgs.dconf ];
        systemd.user.targets.yes = {
          documentation = [ "man:systemd.special(7)" ];
          bindsTo = [ "graphical-session.target" ];
          wants = [ "graphical-session-pre.target" ];
          after = [ "graphical-session-pre.target" ];
        };
        environment.systemPackages = [ dwl ];
        programs.uwsm = {
          enable = true;
          waylandCompositors.dwl = {
            prettyName = "DWL";
            comment = "DWL compositor managed by UWSM";
            binPath = "/run/current-system/sw/bin/dwl";
          };
        };
        xdg.portal.config.dwl.default = [
          "wlr"
          "gtk"
        ];
      }
    ]
  );
}
