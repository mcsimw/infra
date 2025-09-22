{ moduleWithSystem, self, ... }:
{
  flake.modules.nixos.infra =
    (
      { self }:
      moduleWithSystem (
        {
          inputs',
          pkgs,
          ...
        }:
        { config, lib, ... }:
        let
          vars = import (self + /nix/modules/nixos/desktop/_vars.nix) config;
        in
        {
          config = lib.mkIf vars.desktop {
            programs.foot.enable = true;
            environment.systemPackages =
              (with inputs'; [
                browser-previews.packages.google-chrome-dev
                flake-firefox-nightly.packages.firefox-nightly-bin
              ])
              ++ (with pkgs; [
                adwaita-icon-theme
                inkscape
                gimp3
                obs-studio
                kdePackages.kdenlive
                rmpc
                legcord
                mpd
                ((lib.mkIf vars.wayland) wl-clipboard-rs)
                ((lib.mkIf config.programs.wireshark.enable) wireshark)
              ])
              ++ (lib.optionals vars.minimal (
                with pkgs;
                [
                  zathura
                  mpv
                ]
              ))
              ++ (lib.optionals vars.minimalWayland (
                with pkgs;
                [
                  imv
                  mako
                  wmenu
                ]
              ))
              ++ (lib.optionals vars.wlroots (
                with pkgs;
                [
                  sway-contrib.grimshot
                  slurp
                  swaybg
                ]
              ));
          };
        }
      )
    )
      { inherit self; };
}
