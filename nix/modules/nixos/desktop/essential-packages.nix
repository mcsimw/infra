{ moduleWithSystem, ... }:
{
  flake.modules.nixos.infra = moduleWithSystem (
    {
      inputs',
      pkgs,
      ...
    }:
    { config, lib, ... }:
    {
      config = lib.mkIf config.analfabeta.desktop.enable {
        environment.systemPackages =
          (with inputs'; [
            browser-previews.packages.google-chrome-dev
            flake-firefox-nightly.packages.firefox-nightly-bin
          ])
          ++ (with pkgs; [
            adwaita-icon-theme
            inkscape
            gimp3
            wl-clipboard-rs
            obs-studio
            kdePackages.kdenlive
            rmpc
            legcord
            mpd
          ]);
      };
    }
  );
}
