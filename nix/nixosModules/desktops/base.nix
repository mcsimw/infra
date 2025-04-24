{
  inputs',
  pkgs,
  self',
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
        self'.packages.gimp
      ]
      ++ (with pkgs; [
        adwaita-icon-theme
        mpv
        inkscape
        cool-retro-term
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
          "Verdana"
          "Symbols Nerd Font"
        ];
        monospace = [
          "Lucida Sans Typewriter"
          "Symbols Nerd Font Mono"
        ];
        emoji = [ "Apple Color Emoji" ];
      };
    };
    packages =
      [
        inputs'.apple-emoji-linux.packages.default
        inputs'.browser-previews.packages.google-chrome-dev
        self'.packages.lucidia
      ]
      ++ (with pkgs; [
        spleen
        vistafonts
        corefonts
        freefont_ttf
        nerd-fonts.symbols-only
      ]);
  };
}
