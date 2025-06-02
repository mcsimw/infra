{
  self',
  pkgs,
  inputs',
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

  environment.systemPackages =
    [ self'.packages.nyxt ]
    ++ (with pkgs; [
      adwaita-icon-theme
      self'.packages.mpv
      inkscape
      gimp3
      pulsemixer
    ]);

  fonts = {
    fontconfig = {
      useEmbeddedBitmaps = true;
      antialias = false;
      hinting.enable = false;
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
    packages = with pkgs; [
      inputs'.apple-emoji-linux.packages.default
      spleen
      terminus_font
      iosevka
      nerd-fonts.symbols-only
    ];
  };
}
