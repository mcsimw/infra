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
      ]
      ++ (with pkgs; [
        adwaita-icon-theme
        self'.packages.mpv
        inkscape
        cool-retro-term
        gimp3
        nyxt
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
          "Charis SIL"
          "Symbols Nerd Font"
        ];
        sansSerif = [
          "Clear Sans"
          "Symbols Nerd Font"
        ];
        monospace = [
          "Luculent"
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
        freefont_ttf
        nerd-fonts.symbols-only
        noto-fonts
        noto-fonts-cjk-sans
        luculent
        texlivePackages.clearsans
        texlivePackages.charissil
      ]);
  };
}
