{ moduleWithSystem, self, ... }:
{
  flake.modules.nixos.infra =
    (
      { self }:
      moduleWithSystem (
        {
          inputs',
          pkgs,
          self',
          ...
        }:
        { config, lib, ... }:
        let
          vars = import (self + /nix/modules/nixos/desktop/_vars.nix) config;
        in
        {
          config = lib.mkIf vars.desktop {
            programs = {
              foot.enable = true;
              firefox = {
                enable = true;
                package = lib.mkDefault inputs'.flake-firefox-nightly.packages.firefox-nightly-bin;
              };
            };
            environment.systemPackages = [
              inputs'.browser-previews.packages.google-chrome-dev
            ]
            ++ (with pkgs; [
              adwaita-icon-theme
              inkscape
              gimp3
              obs-studio
              kdePackages.kdenlive
              rmpc
              legcord
              mpd
              ani-cli
              ((lib.mkIf vars.wayland) wl-clipboard-rs)
              ((lib.mkIf config.programs.wireshark.enable) wireshark)
            ])
            ++ (lib.optionals vars.minimal [
              pkgs.zathura
              self'.packages.mpv
            ])
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
