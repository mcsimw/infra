{
  inputs',
  self',
  pkgs,
  ...
}:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  programs = {
    firefox = {
      enable = true;
      package = inputs'.flake-firefox-nightly.packages.firefox-nightly-bin;
    };
  };

  environment = {
    systemPackages =
      [
        inputs'.browser-previews.packages.google-chrome-dev
        self'.packages.nyxt
      ]
      ++ (with pkgs; [
        adwaita-icon-theme
        self'.packages.mpv
        inkscape
        cool-retro-term
        gimp3
        qutebrowser
      ]);
  };

  fonts = {
    fontconfig = {
      useEmbeddedBitmaps = true;
      antialias = false; # Fuck you blur
      hinting.enable = false; # Fuck you blur
      subpixel.lcdfilter = "none";
      defaultFonts = {
        serif = [
          "Georgia"
          "Symbols Nerd Font"
        ];
        sansSerif = [
          "Segoe UI Variable"
          "Symbols Nerd Font"
        ];
        monospace = [
          "Lucida Console"
          "Symbols Nerd Font Mono"
        ];
        emoji = [ "Apple Color Emoji" ];
      };
    };
    packages =
      [
        inputs'.apple-emoji-linux.packages.default
      ]
      ++ (with pkgs; [
        spleen
        nerd-fonts.symbols-only
      ]);
  };
}
