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
          "Lucida Console"
          "Symbols Nerd Font Mono"
        ];
        emoji = [ "Apple Color Emoji" ];
      };
    };
    packages = with pkgs; [
      inputs'.apple-emoji-linux.packages.default
      spleen
      cascadia-code
      nerd-fonts.symbols-only
    ];
  };
}
